/// The round trip check used for all upstream test data: read the JSON,
/// generate JSON again, and compare.
library;

import 'dart:convert';

import 'package:test/test.dart';

import 'validation.dart';

/// Parses a JSON value into a Dart object which can be encoded as JSON again.
typedef JsonParser = Object Function(Object? json);

/// Validates a JSON value against its schema.
typedef JsonValidator = Future<List<SchemaError>> Function(Object? json);

/// A known issue with an upstream test file, which is expected to make the
/// round trip fail in a specific way.
///
/// If the issue is fixed upstream, the test fails, saying that the known
/// issue should be removed. This way, known issues cannot hide new problems.
class KnownIssue {
  /// Why this file is expected to fail.
  final String reason;

  /// The file cannot be parsed.
  final bool parseFails;

  /// JSON paths (e.g. `$.body.description`) which are expected to differ
  /// after the round trip.
  final Set<String> ignoredDifferences;

  /// JSON pointers (e.g. `/header/external_datasheets/0/datasheet_reference`)
  /// at which the generated JSON is expected not to comply with the schema.
  final Set<String> ignoredSchemaErrors;

  const KnownIssue(
    this.reason, {
    this.parseFails = false,
    this.ignoredDifferences = const {},
    this.ignoredSchemaErrors = const {},
  });
}

/// Checks that [input] from [source] can be read using [parse], and that
/// generating JSON from the result gives the same JSON as the [input].
///
/// If a [validate] function is given, the generated JSON must also comply
/// with its schema.
///
/// The generated JSON is then read and generated again, which must give
/// exactly the same JSON.
Future<void> checkRoundTrip(
  Uri source,
  Object? input,
  JsonParser parse, {
  JsonValidator? validate,
  KnownIssue? knownIssue,
}) async {
  if (knownIssue != null && knownIssue.parseFails) {
    expect(
      () => parse(input),
      throwsA(anything),
      reason:
          'Known issue "${knownIssue.reason}" seems to be fixed in $source. '
          'Remove it from the known issues.',
    );
    return;
  }

  // Read and generate.
  final generated = json.decode(json.encode(parse(input)));

  // Compare with the input.
  final ignored = knownIssue?.ignoredDifferences ?? const <String>{};
  final differences = jsonDifferences(input, generated);
  expect(
    differences.where((d) => !ignored.contains(d.path)).toList(),
    isEmpty,
    reason: 'The generated JSON differs from $source',
  );
  for (final path in ignored) {
    expect(
      differences.map((d) => d.path),
      contains(path),
      reason:
          'Known issue "${knownIssue!.reason}" seems to be fixed in $source. '
          'Remove it from the known issues.',
    );
  }

  // Validate the generated JSON against its schema.
  if (validate != null) {
    final ignoredErrors =
        knownIssue?.ignoredSchemaErrors ?? const <String>{};
    final errors = await validate(generated);
    expect(
      errors.where((e) => !ignoredErrors.contains(e.path)).toList(),
      isEmpty,
      reason: 'The JSON generated from $source does not comply with its schema',
    );
    for (final path in ignoredErrors) {
      expect(
        errors.map((e) => e.path),
        contains(path),
        reason:
            'Known issue "${knownIssue!.reason}" seems to be fixed in $source. '
            'Remove it from the known issues.',
      );
    }
  }

  // Read back the generated JSON and generate again.
  expect(
    json.encode(parse(generated)),
    equals(json.encode(generated)),
    reason: 'Reading back the generated JSON gives a different result',
  );
}

/// A difference between two JSON values at [path].
class JsonDifference {
  final String path;
  final String description;
  JsonDifference(this.path, this.description);

  @override
  String toString() => '$path: $description';
}

/// The differences between the JSON values [expected] and [actual].
///
/// The values are compared semantically: numbers are compared by value
/// (`19` equals `19.0`), and date-time strings are compared as instants
/// (`2019-03-29T08:26:03+01:00` equals `2019-03-29T07:26:03.000Z`).
List<JsonDifference> jsonDifferences(
  Object? expected,
  Object? actual, [
  String path = r'$',
]) {
  if (expected is Map && actual is Map) {
    return [
      for (final key in {...expected.keys, ...actual.keys})
        if (!expected.containsKey(key))
          JsonDifference('$path.$key', 'not expected, but generated')
        else if (!actual.containsKey(key))
          JsonDifference('$path.$key', 'expected, but not generated')
        else
          ...jsonDifferences(expected[key], actual[key], '$path.$key'),
    ];
  }
  if (expected is List && actual is List) {
    if (expected.length != actual.length) {
      return [
        JsonDifference(
          path,
          'expected ${expected.length} elements, '
          'but generated ${actual.length}',
        ),
      ];
    }
    return [
      for (var i = 0; i < expected.length; i++)
        ...jsonDifferences(expected[i], actual[i], '$path[$i]'),
    ];
  }
  if (expected is num && actual is num && expected == actual) return [];
  if (expected is String && actual is String && expected != actual) {
    final expectedTime = _dateTime(expected);
    final actualTime = _dateTime(actual);
    if (expectedTime != null &&
        actualTime != null &&
        expectedTime.isAtSameMomentAs(actualTime)) {
      return [];
    }
  }
  return expected == actual
      ? []
      : [
          JsonDifference(
            path,
            'expected ${json.encode(expected)}, '
            'but generated ${json.encode(actual)}',
          ),
        ];
}

/// Parses [value] as a date-time, if it contains both a date and a time.
DateTime? _dateTime(String value) =>
    value.contains('T') ? DateTime.tryParse(value) : null;
