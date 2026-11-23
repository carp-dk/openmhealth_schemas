part of '../openmhealth_schemas.dart';

/// An abstract class represent any IEEE 1752.1 or OMH schema.
abstract class SchemaSupport {
  static const String OMH_NAMESPACE = 'omh';
  static const String IEEE_NAMESPACE = 'ieee';
  static const String CARP_NAMESPACE = 'carp';

  static const String ACCELERATION = 'acceleration';
  static const String ACTIVITY = 'physical-activity';
  static const String BLOOD_PRESSURE = 'blood-pressure';
  static const String SYSTOLIC_BLOOD_PRESSURE = 'systolic-blood-pressure';
  static const String DIASTOLIC_BLOOD_PRESSURE = 'diastolic-blood-pressure';
  static const String HEART_RATE = 'heart-rate';
  static const String RR_INTERVAL = 'rr-interval';
  static const String DATA_POINT = 'data-point';
  static const String GEOPOSITION = 'geoposition';
  static const String MEASURE = 'abstract-measure';
  static const String SCHEMA = 'schema';
  static const String SURVEY = 'survey';
  static const String SURVEY_ITEM = 'survey-item';
  static const String SURVEY_QUESTION = 'survey-question';
  static const String SURVEY_ANSWER = 'survey-answer';
  static const String TIME_FRAME = 'time-frame';
  static const String TIME_INTERVAL = 'time-interval';
  static const String UNITS = 'units';
  static const String CALORIES = 'calories-burned';

  /// The schema this class corresponds to
  SchemaId getSchemaId();
}

/// An abstract class represent schema enumerations.
abstract class SchemaEnumValue {
  ///The schema enumeration value
  String schemaValue;

  SchemaEnumValue(this.schemaValue);
}

/// A schema identifier. It consists of a namespace, a name, and a version. A schema identifier unambiguously identifies
/// a single, immutable schema. The namespace is used to avoid naming collisions in schemas written by different groups
/// or organisations.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/schema-id-1.0.json">schema-id</a>
class SchemaId implements SchemaSupport, Comparable<SchemaId> {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'schema-id',
    SchemaVersion.V1_0,
  );

  /// The namespace of the schema, e.g. `ieee` or `omh`.
  final String namespace;

  /// The name of the schema, e.g. `heart-rate`.
  final String name;

  /// The version of the schema.
  final SchemaVersion schemaVersion;

  /// The version as given when this schema id was created from a string.
  final String? _version;

  /// Creates a schema id with the [version] as a string, e.g. `1.0`.
  SchemaId({
    required this.namespace,
    required this.name,
    required String version,
  }) : schemaVersion = SchemaVersion.fromString(version),
       _version = version;

  /// Creates a schema id with the [schemaVersion].
  const SchemaId.withVersion(this.namespace, this.name, this.schemaVersion)
    : _version = null;

  /// The version of the schema as a string, e.g. `1.0`.
  String get version => _version ?? schemaVersion.toString();

  factory SchemaId.fromJson(Map<String, dynamic> json) => SchemaId(
    namespace: json['namespace'] as String,
    name: json['name'] as String,
    version: json['version'] as String,
  );

  Map<String, dynamic> toJson() => {
    'namespace': namespace,
    'name': name,
    'version': version,
  };

  @override
  int compareTo(SchemaId other) {
    if (namespace.compareTo(other.namespace) != 0) {
      return namespace.compareTo(other.namespace);
    }

    if (name.compareTo(other.name) != 0) return name.compareTo(other.name);

    return schemaVersion.compareTo(other.schemaVersion);
  }

  @override
  SchemaId getSchemaId() => SCHEMA_ID;

  @override
  String toString() => '$namespace.$name.v$version';
}

/// A semantic schema version, consisting of a major number, minor number, and an optional qualifier.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SchemaVersion implements Comparable<SchemaVersion> {
  //static const Pattern QUALIFIER_PATTERN = Pattern.compile(QUALIFIER_PATTERN_STRING);
  //static const String VERSION_PATTERN_STRING = "(\\d+)\\.(\\d+)(?:\\.(" + QUALIFIER_PATTERN_STRING + "))?";
  //final Pattern VERSION_PATTERN = Pattern.compile(VERSION_PATTERN_STRING);

  static const SchemaVersion V1_0 = SchemaVersion(major: 1, minor: 0);
  static const SchemaVersion V1_1 = SchemaVersion(major: 1, minor: 1);
  static const SchemaVersion V1_2 = SchemaVersion(major: 1, minor: 2);
  static const SchemaVersion V2_0 = SchemaVersion(major: 2, minor: 0);
  static const SchemaVersion V3_0 = SchemaVersion(major: 3, minor: 0);
  static const SchemaVersion V4_0 = SchemaVersion(major: 4, minor: 0);

  final int major;
  final int minor;
  final String? qualifier;

  //TODO : should check if this is a valid version - see original OMH Java implementation.
  const SchemaVersion({this.major = 1, this.minor = 0, this.qualifier});

  factory SchemaVersion.v10() => V1_0;

  /// Creates a version from a string such as `1.0` or `1.0.RC1`.
  factory SchemaVersion.fromString(String version) {
    final parts = version.split('.');
    return SchemaVersion(
      major: parts.isNotEmpty ? int.parse(parts[0]) : 1,
      minor: parts.length > 1 ? int.parse(parts[1]) : 0,
      qualifier: parts.length > 2 ? parts[2] : null,
    );
  }

  factory SchemaVersion.fromJson(Map<String, dynamic> json) =>
      _$SchemaVersionFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaVersionToJson(this);

  /// Check if [version] is a valid OMH schema.
  static bool isValidVersion(String version) {
    return (int.parse(version.split('.').first) > 0);
    // TODO : implement pattern match.
    //return version == null || VERSION_PATTERN.matcher(version).matches();
  }

  /// Compares this [SchemaVersion] to another.
  ///
  /// Returns a negative integer if [this] is a older version than [other],
  /// a positive integer if [this] a newer version than [other]
  /// and zero if they are the same version.
  @override
  int compareTo(SchemaVersion other) {
    if (major < other.major) return -1;
    if (major > other.major) return 1;
    if (minor < other.minor) return -1;
    if (minor > other.minor) return 1;
    if (qualifier == null && other.qualifier == null) return 0;
    // A version with a qualifier (a pre-release) comes before the release.
    if (qualifier != null && other.qualifier == null) return -1;
    if (qualifier == null && other.qualifier != null) return 1;

    return qualifier!.compareTo(other.qualifier!);
  }

  @override
  String toString() =>
      '$major.$minor${(qualifier != null) ? '.$qualifier' : ''}';
}
