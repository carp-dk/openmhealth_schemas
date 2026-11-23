/// Tests all sample data of the IEEE 1752 repository, loaded directly from
/// https://opensource.ieee.org/omh/1752/-/tree/main/sample_data
///
/// For each sample file, the JSON is read into the Dart class of its schema,
/// JSON is generated again, compared to the sample, and validated against the
/// schema. In addition, the schemas of the repository are checked to be
/// supported by this package.
///
/// These tests need network access. Skip them with `dart test -x remote`.
@Tags(['remote'])
library;

import 'package:test/test.dart';

import 'support/remote.dart';
import 'support/round_trip.dart';
import 'support/schemas.dart';
import 'support/validation.dart';

/// The IEEE metadata samples use placeholders such as
/// "iri-of-some-study-protocol" as datasheet references, which are not valid
/// IRIs as required by the header schema.
const String _placeholderIris =
    'the datasheet references are placeholders, not valid IRIs';
const Set<String> _datasheetReferences = {
  '/header/external_datasheets/0/datasheet_reference',
  '/header/external_datasheets/1/datasheet_reference',
};

/// Known issues in the IEEE sample data, by path.
const Map<String, KnownIssue> knownIssues = {
  'sample_data/metadata/data-point-sample-data-ambient-temp.json': KnownIssue(
    _placeholderIris,
    ignoredSchemaErrors: _datasheetReferences,
  ),
  'sample_data/metadata/data-point-sample-data-phys-activity.json': KnownIssue(
    _placeholderIris,
    ignoredSchemaErrors: _datasheetReferences,
  ),
  'sample_data/metadata/data-series-sample-series-ambient-temp.json':
      KnownIssue(_placeholderIris, ignoredSchemaErrors: _datasheetReferences),
  'sample_data/metadata/header-sample-data.json': KnownIssue(
    _placeholderIris,
    ignoredSchemaErrors: {
      '/external_datasheets/0/datasheet_reference',
      '/external_datasheets/1/datasheet_reference',
    },
  ),
  'sample_data/environment/ambient-temperature-sample-data-two.json':
      KnownIssue(
        'invalid date-time "2013-02-05T012:25:00Z" (three digit hour)',
        parseFails: true,
      ),
  'sample_data/sleep/sleep-stage-summary-sample-data-three.json': KnownIssue(
    'uses "awake_sleep_duration" instead of "awake_duration" '
    'as defined in the sleep-stage-summary schema',
    ignoredDifferences: {r'$.sleep_stage_summary.awake_sleep_duration'},
  ),
  'sample_data/sleep/sleep-stage-summary-sample-data-four.json': KnownIssue(
    'uses "total_sleep_efficiency_percentage", "awake_sleep_duration", and '
    '"awake_sleep_percentage" instead of "sleep_efficiency_percentage", '
    '"awake_duration", and "awake_percentage" as defined in the '
    'sleep-stage-summary schema',
    ignoredDifferences: {
      r'$.sleep_stage_summary.total_sleep_efficiency_percentage',
      r'$.sleep_stage_summary.awake_sleep_duration',
      r'$.sleep_stage_summary.awake_sleep_percentage',
    },
  ),
};

/// Removes the `description` of a sample, i.e., a text explaining the example,
/// which is not part of the schemas. It is used in the physical activity and
/// data point samples.
Object? withoutDescription(Object? sample) {
  if (sample is! Map<String, dynamic>) return sample;
  final copy = Map<String, dynamic>.of(sample)..remove('description');
  if (copy['body'] is Map<String, dynamic>) {
    copy['body'] = Map<String, dynamic>.of(
      copy['body'] as Map<String, dynamic>,
    )..remove('description');
  }
  return copy;
}

/// Sample files which are not data, with the reason.
String? excluded(String path) {
  final name = path.split('/').last;
  if (path.startsWith('sample_data/survey/') &&
      name.startsWith('example-survey-')) {
    return 'JSON Schema of an example survey, not data';
  }
  return null;
}

/// The name of the schema of the sample file at [path].
String? schemaOf(String path) {
  final name = path.split('/').last;
  if (path.startsWith('sample_data/survey/')) return 'survey';
  return RegExp(r'^(.+?)-sample-(data|series)').firstMatch(name)?[1];
}

Future<void> main() async {
  final List<String> samples;
  final List<String> schemas;
  try {
    samples = (await Ieee.list(
      'sample_data',
    )).where((path) => path.endsWith('.json')).toList();
    schemas = (await Ieee.list(
      'schemas',
    )).where((path) => path.endsWith('.json')).toList();
  } on UpstreamException catch (error) {
    test('IEEE 1752 repository', () => fail('$error'));
    return;
  }

  final data = prefetch({
    for (final path in samples)
      if (excluded(path) == null) path: Ieee.raw(path),
  });

  final validator = SchemaValidator(schemas);
  JsonValidator validatorFor(String schema) => switch (schema) {
    'data-point' || 'data-series' => (json) =>
        validator.validateDataPoint(json! as Map<String, dynamic>),
    _ => (json) => validator.validate(SchemaValidator.ieeeUrl(schema), json),
  };

  group('IEEE sample data', () {
    for (final path in samples) {
      test(
        path.substring('sample_data/'.length),
        () async {
          final schema = schemaOf(path);
          final supported = ieeeSchemas[schema];
          expect(
            supported,
            isNotNull,
            reason: 'No Dart class for the schema "$schema" of $path',
          );
          await checkRoundTrip(
            Ieee.raw(path),
            withoutDescription(await data[path]),
            supported!.parse,
            validate: validatorFor(schema!),
            knownIssue: knownIssues[path],
          );
        },
        skip: excluded(path),
      );
    }

    test('known issues refer to existing sample files', () {
      expect(samples, containsAll(knownIssues.keys));
    });
  });

  group('IEEE schemas', () {
    for (final path in schemas) {
      final file = schemaFileName(path);
      if (file == null) continue;
      final supported = ieeeSchemas[file.name];

      test('${file.name} ${file.version} is supported', () {
        expect(
          supported,
          isNotNull,
          reason: 'No Dart class for the IEEE schema ${Ieee.raw(path)}',
        );
        expect(
          supported!.version.toString(),
          file.version,
          reason: 'This package implements version ${supported.version}',
        );
      });

      if (supported?.values != null) {
        test('${file.name} values match the schema', () async {
          final schema = await getJson(Ieee.raw(path)) as Map<String, dynamic>;
          expect(supported!.values, unorderedEquals(schema['enum'] as List));
        });
      }
    }
  });
}
