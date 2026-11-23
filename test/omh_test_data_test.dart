/// Tests the OMH schemas of this package with the test data of the Open mHealth
/// repository, loaded directly from
/// https://github.com/openmhealth/schemas/tree/main/test-data
///
/// For each OMH schema supported by this package, all valid (`shouldPass`)
/// test files of the implemented version are read into the Dart class of the
/// schema, JSON is generated again, and compared to the test file. If there is
/// no test data for the implemented version, the test data of the latest
/// earlier version with the same major version is used.
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
  try {
    files = await Omh.list();
  } on UpstreamException catch (error) {
    test('OMH repository', () => fail('$error'));
    return;
  }

  // The valid test files to use, by schema name.
  final testFiles = <String, List<String>>{};
  for (final MapEntry(key: name, value: supported) in omhSchemas.entries) {
    final version = testDataVersion(name, '${supported.version}', files);
    testFiles[name] = [
      if (version != null)
        ...files.where(
          (path) =>
              path.startsWith('test-data/omh/$name/$version/shouldPass/') &&
              path.endsWith('.json'),
        ),
    ];
  }

  final data = prefetch({
    for (final path in testFiles.values.expand((paths) => paths))
      path: Omh.raw(path),
  });

  group('OMH test data', () {
    for (final MapEntry(key: name, value: paths) in testFiles.entries) {
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
          checkRoundTrip(
            Omh.raw(path),
            await data[path],
            omhSchemas[name]!.parse,
            knownIssue: knownIssues[path],
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
