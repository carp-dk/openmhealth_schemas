/// Tests the OMH schemas of this package with the test data of the Open mHealth
/// repository, loaded directly from
/// https://github.com/openmhealth/schemas/tree/main/test-data
///
/// For each OMH schema supported by this package, all valid (`shouldPass`)
/// test files of the implemented version are read into the Dart class of the
/// schema, JSON is generated again, compared to the test file, and validated
/// against the schema. If there is no test data for the implemented version,
/// the test data of the latest earlier version with the same major version is
/// used.
///
/// All invalid (`shouldFail`) test files are checked to be rejected by the
/// schema validation, which shows that the validation works.
///
/// In addition, the supported schemas are checked to be the latest version in
/// the repository.
///
/// These tests need network access. Skip them with `dart test -x remote`.
@Tags(['remote'])
library;

import 'package:test/test.dart';

import 'support/remote.dart';
import 'support/round_trip.dart';
import 'support/schemas.dart';
import 'support/validation.dart';

/// Known issues in the OMH test data, by path.
const Map<String, KnownIssue> knownIssues = {};

/// The version of the test data to use for [name], given the [implemented]
/// version and the [files] in the repository.
String? testDataVersion(String name, String implemented, List<String> files) {
  final major = implemented.split('.').first;
  final versions =
      files
          .where((path) => path.startsWith('test-data/omh/$name/'))
          .map((path) => path.split('/')[3])
          .where(
            (version) =>
                version.split('.').first == major &&
                compareVersions(version, implemented) <= 0,
          )
          .toSet()
          .toList()
        ..sort(compareVersions);
  return versions.isEmpty ? null : versions.last;
}

Future<void> main() async {
  final List<String> files;
  final SchemaValidator validator;
  try {
    files = await Omh.list();
    // The OMH schemas refer to IEEE schemas.
    validator = SchemaValidator(await Ieee.list('schemas'));
  } on UpstreamException catch (error) {
    test('OMH and IEEE repositories', () => fail('$error'));
    return;
  }

  // The valid and invalid test files to use, by schema name.
  final validFiles = <String, List<String>>{};
  final invalidFiles = <String, List<String>>{};
  for (final MapEntry(key: name, value: supported) in omhSchemas.entries) {
    final version = testDataVersion(name, '${supported.version}', files);
    List<String> testFiles(String kind) => [
      if (version != null)
        ...files.where(
          (path) =>
              path.startsWith('test-data/omh/$name/$version/$kind/') &&
              path.endsWith('.json'),
        ),
    ];
    validFiles[name] = testFiles('shouldPass');
    invalidFiles[name] = testFiles('shouldFail');
  }

  final data = prefetch({
    for (final path in [
      ...validFiles.values.expand((paths) => paths),
      ...invalidFiles.values.expand((paths) => paths),
    ])
      path: Omh.raw(path),
  });

  String schemaUrl(String name) =>
      SchemaValidator.omhUrl(name, '${omhSchemas[name]!.version}');

  group('OMH test data', () {
    for (final MapEntry(key: name, value: paths) in validFiles.entries) {
      if (paths.isEmpty) {
        test(
          name,
          () => fail(
            'No OMH test data for $name ${omhSchemas[name]!.version} '
            'or an earlier version with the same major version',
          ),
        );
      }
      for (final path in paths) {
        test(path.substring('test-data/omh/'.length), () async {
          await checkRoundTrip(
            Omh.raw(path),
            await data[path],
            omhSchemas[name]!.parse,
            validate: (json) => validator.validate(schemaUrl(name), json),
            knownIssue: knownIssues[path],
          );
        });
      }
    }
  });

  group('OMH invalid test data is rejected by the schema validation', () {
    for (final MapEntry(key: name, value: paths) in invalidFiles.entries) {
      for (final path in paths) {
        test(path.substring('test-data/omh/'.length), () async {
          expect(
            await validator.validate(schemaUrl(name), await data[path]),
            isNotEmpty,
            reason:
                '${Omh.raw(path)} should not comply with ${schemaUrl(name)}',
          );
        });
      }
    }
  });

  group('OMH schemas', () {
    for (final MapEntry(key: name, value: supported) in omhSchemas.entries) {
      final versions =
          files
              .where((path) => path.startsWith('schema/omh/'))
              .map(schemaFileName)
              .where((file) => file?.name == name)
              .map((file) => file!.version)
              .toList()
            ..sort(compareVersions);

      test('$name ${supported.version} is the latest version', () {
        expect(versions, isNotEmpty, reason: 'No OMH schema named $name');
        expect('${supported.version}', versions.last);
      });

      if (supported.values != null && versions.isNotEmpty) {
        test('$name values match the schema', () async {
          final schema =
              await getJson(
                    Omh.raw('schema/omh/$name-${supported.version}.json'),
                  )
                  as Map<String, dynamic>;
          expect(supported.values, unorderedEquals(schema['enum'] as List));
        });
      }
    }
  });
}
