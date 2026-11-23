/// Validation of JSON against the IEEE 1752.1 and OMH JSON Schemas, loaded
/// directly from the upstream repositories.
library;

import 'dart:convert';

import 'package:json_schema/json_schema.dart';

import 'remote.dart';
import 'schemas.dart' show schemaFileName;

/// A JSON value which does not comply with its schema.
typedef SchemaError = ({String path, String message});

/// Validates JSON against the IEEE 1752.1 and OMH schemas.
///
/// The schemas are identified by their URL, e.g.
/// `https://w3id.org/ieee/ieee-1752-schema/deep-sleep-1.0.json`, and are loaded
/// from the IEEE and OMH repositories.
///
/// The `json_schema` package cannot resolve the references (`$ref`) used in
/// these schemas, e.g. a definition which refers to another schema file.
/// Hence, all references are resolved here, and the validator is given a
/// schema without references.
class SchemaValidator {
  static const String ieeeBase = 'https://w3id.org/ieee/ieee-1752-schema/';
  static const String omhBase = 'https://w3id.org/openmhealth/schemas/omh/';

  /// The path of each IEEE schema in the IEEE repository, by schema name.
  final Map<String, String> _ieeePaths;

  final Map<String, Future<Map<String, dynamic>>> _documents = {};
  final Map<String, Future<JsonSchema>> _schemas = {};

  /// Creates a validator, given the paths of the schema files in the IEEE
  /// repository (see [Ieee.list]).
  SchemaValidator(List<String> ieeeSchemaPaths)
    : _ieeePaths = {
        for (final path in ieeeSchemaPaths)
          if (schemaFileName(path) case final file?) file.name: path,
      };

  /// The URL of the IEEE schema [name].
  static String ieeeUrl(String name, [String version = '1.0']) =>
      '$ieeeBase$name-$version.json';

  /// The URL of the OMH schema [name] in [version].
  static String omhUrl(String name, String version) =>
      '$omhBase$name-$version.json';

  /// Validates [json] against the schema at [url].
  Future<List<SchemaError>> validate(String url, Object? json) async =>
      (await _schema(url))
          .validate(json)
          .errors
          .map(
            (error) => (
              path: error.instancePath.isEmpty ? '/' : error.instancePath,
              message: error.message,
            ),
          )
          .toList();

  /// Validates a data point or data series.
  ///
  /// The IEEE data point and data series schemas only require the body to be
  /// a JSON object. Hence, the body is also validated against the schema
  /// identified in the header, if this is an IEEE or OMH schema.
  Future<List<SchemaError>> validateDataPoint(Map<String, dynamic> json) async {
    final isSeries = json['body'] is List;
    final errors = await validate(
      ieeeUrl(isSeries ? 'data-series' : 'data-point'),
      json,
    );

    final schemaId =
        (json['header'] as Map<String, dynamic>)['schema_id']
            as Map<String, dynamic>;
    final name = schemaId['name'] as String;
    final version = schemaId['version'] as String;
    final bodyUrl = switch (schemaId['namespace']) {
      'ieee' => ieeeUrl(name, version),
      'omh' => omhUrl(name, version),
      _ => null,
    };
    if (bodyUrl == null) return errors;

    final bodies = isSeries ? json['body'] as List<dynamic> : [json['body']];
    for (var i = 0; i < bodies.length; i++) {
      final prefix = isSeries ? '/body/$i' : '/body';
      errors.addAll(
        (await validate(bodyUrl, bodies[i])).map(
          (error) => (
            path: error.path == '/' ? prefix : '$prefix${error.path}',
            message: error.message,
          ),
        ),
      );
    }
    return errors;
  }

  Future<JsonSchema> _schema(String url) => _schemas.putIfAbsent(url, () async {
    final document = await _document(url);
    final resolved = await _resolve(document, Uri.parse(url), document);
    return JsonSchema.create({
      r'$schema': 'http://json-schema.org/draft-07/schema#',
      ...resolved! as Map<String, dynamic>,
    });
  });

  /// The location in the IEEE or OMH repository of the schema at [url].
  Uri _location(String url) {
    if (url.startsWith(ieeeBase)) {
      // IEEE schemas are referred to both with and without a version, e.g.
      // 'header.json' and 'header-1.0.json'.
      final name = url
          .substring(ieeeBase.length)
          .replaceFirst(RegExp(r'(-\d+\.\d+)?\.json$'), '');
      final path = _ieeePaths[name];
      if (path == null) throw ArgumentError('Unknown IEEE schema: $url');
      return Ieee.raw(path);
    }
    if (url.startsWith(omhBase)) {
      return Omh.raw('schema/omh/${url.substring(omhBase.length)}');
    }
    throw ArgumentError('Unknown schema location: $url');
  }

  /// The JSON schema document at [url].
  Future<Map<String, dynamic>> _document(String url) =>
      _documents.putIfAbsent(url, () async {
        var location = _location(url);
        var text = await getText(location);
        // Some OMH schema files, e.g. 'heart-rate-1.x.json', are symbolic
        // links, which the repository returns as the name of the target file.
        while (!text.trimLeft().startsWith('{')) {
          location = location.resolve(text.trim());
          text = await getText(location);
        }
        return json.decode(text) as Map<String, dynamic>;
      });

  /// Resolves all references in [node], which is part of the schema
  /// [document] at [base].
  Future<Object?> _resolve(
    Object? node,
    Uri base,
    Map<String, dynamic> document, [
    int depth = 0,
  ]) async {
    if (depth > 100) throw StateError('Recursive schema at $base');

    if (node is List) {
      return Future.wait([
        for (final element in node)
          _resolve(element, base, document, depth + 1),
      ]);
    }
    if (node is! Map<String, dynamic>) return node;

    final ref = node[r'$ref'];
    if (ref is String) {
      // Properties next to a reference are ignored in JSON Schema draft-07.
      final target = base.resolve(ref);
      final targetUrl = target.removeFragment().toString();
      var targetBase = base;
      var targetDocument = document;
      if (targetUrl != base.removeFragment().toString()) {
        targetBase = Uri.parse(targetUrl);
        targetDocument = await _document(targetUrl);
      }
      Object? schema = targetDocument;
      for (final part in target.fragment.split('/').where((p) => p.isNotEmpty)) {
        schema = (schema as Map<String, dynamic>)[part];
      }
      return _resolve(schema, targetBase, targetDocument, depth + 1);
    }

    // All references are resolved, so definitions, ids, and the schema
    // version of included schemas are no longer needed.
    final entries = node.entries.where(
      (entry) => !const {r'$id', r'$schema', 'definitions'}.contains(entry.key),
    );
    final values = await Future.wait([
      for (final entry in entries)
        _resolve(entry.value, base, document, depth + 1),
    ]);
    return Map<String, dynamic>.fromIterables(
      entries.map((entry) => entry.key),
      values,
    );
  }
}
