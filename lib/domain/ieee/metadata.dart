part of '../../openmhealth_schemas.dart';

/// An IEEE 1752.1 data point, consisting of a [header] and a [body].
///
/// The [body] can be any [Measure], including the original OMH measures that
/// have not (yet) been standardized by IEEE 1752.1, such as `HeartRate`. The
/// [DataPointHeader.schemaId] identifies the schema of the body, including
/// its namespace (`ieee` or `omh`).
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/data-point-1.0.json">data-point</a>
@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  constructor: '_',
)
class DataPoint implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.DATA_POINT,
    SchemaVersion.V1_0,
  );

  DataPointHeader header;
  Measure body;

  DataPoint._(this.header, this.body);

  /// Creates a [DataPoint] encapsulating the measure specified in [body].
  ///
  /// A header is created automatically, with a random (version 4) UUID and
  /// the schema id of [body]. If [sourceCreationDateTime] is not specified,
  /// the current UTC time is used.
  DataPoint({
    required this.body,
    DateTime? sourceCreationDateTime,
    String? modality,
    FrequencyUnitValue? acquisitionRate,
    List<ExternalDatasheet>? externalDatasheets,
  }) : header = DataPointHeader(
         uuid: const Uuid().v4(),
         schemaId: body.getSchemaId(),
         sourceCreationDateTime:
             sourceCreationDateTime ?? DateTime.now().toUtc(),
         modality: modality,
         acquisitionRate: acquisitionRate,
         externalDatasheets: externalDatasheets,
       );

  factory DataPoint.fromJson(Map<String, dynamic> json) =>
      _$DataPointFromJson(json);
  Map<String, dynamic> toJson() => _$DataPointToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// An IEEE 1752.1 data series, i.e., a list of measures in the [body] that
/// share the same [header].
///
/// All measures in the [body] must comply with the schema identified by the
/// [DataPointHeader.schemaId] of the [header].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/data-series-1.0.json">data-series</a>
@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  constructor: '_',
)
class DataSeries implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'data-series',
    SchemaVersion.V1_0,
  );

  DataPointHeader header;
  List<Measure> body;

  DataSeries._(this.header, this.body);

  /// Creates a [DataSeries] encapsulating the list of measures in [body].
  ///
  /// A header is created automatically, with a random (version 4) UUID.
  /// The schema id of the header is [schemaId] if specified, and otherwise the
  /// schema id of the first measure in [body]. Hence, if [body] is empty,
  /// [schemaId] must be specified. If [sourceCreationDateTime] is not
  /// specified, the current UTC time is used.
  DataSeries({
    required this.body,
    SchemaId? schemaId,
    DateTime? sourceCreationDateTime,
    String? modality,
    FrequencyUnitValue? acquisitionRate,
    List<ExternalDatasheet>? externalDatasheets,
  }) : assert(
         body.isNotEmpty || schemaId != null,
         'The schema id must be specified for an empty data series.',
       ),
       header = DataPointHeader(
         uuid: const Uuid().v4(),
         schemaId: schemaId ?? body.first.getSchemaId(),
         sourceCreationDateTime:
             sourceCreationDateTime ?? DateTime.now().toUtc(),
         modality: modality,
         acquisitionRate: acquisitionRate,
         externalDatasheets: externalDatasheets,
       ) {
    assert(
      body.every((m) => m.getSchemaId().compareTo(header.schemaId) == 0),
      'All measures in a data series must have the schema id of the header.',
    );
  }

  factory DataSeries.fromJson(Map<String, dynamic> json) =>
      _$DataSeriesFromJson(json);
  Map<String, dynamic> toJson() => _$DataSeriesToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The header of an IEEE 1752.1 data point or data series.
///
/// Compared to the OMH header, the IEEE header has no `user_id` and no
/// `acquisition_provenance`. Instead, [sourceCreationDateTime] and [modality]
/// are top-level properties, and [acquisitionRate] and [externalDatasheets]
/// have been added.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/header-1.0.json">header</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DataPointHeader implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'header',
    SchemaVersion.V1_0,
  );

  /// The identifier of this data point: a globally unique value, generated
  /// using the RFC 4122 approach.
  String uuid;

  /// The schema identifier of the body of the data point or data series.
  SchemaId schemaId;

  /// The date time (timestamp) when this data point or data series was
  /// created at the original source.
  DateTime sourceCreationDateTime;

  /// The modality whereby the measure is obtained. See [DataPointModality].
  String? modality;

  /// The rate at which measures are acquired.
  FrequencyUnitValue? acquisitionRate;

  /// References to external documentation relevant to describe the
  /// collection, computation, use, etc. of this data point or data series.
  List<ExternalDatasheet>? externalDatasheets;

  /// Creates a [DataPointHeader]. The [uuid], [schemaId], and
  /// [sourceCreationDateTime] are required.
  ///
  /// Note that normally you would not create a [DataPointHeader], but instead
  /// create a [DataPoint], which takes care of creating its own header.
  DataPointHeader({
    required this.uuid,
    required this.schemaId,
    required this.sourceCreationDateTime,
    this.modality,
    this.acquisitionRate,
    this.externalDatasheets,
  });

  factory DataPointHeader.fromJson(Map<String, dynamic> json) =>
      _$DataPointHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$DataPointHeaderToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A reference to external documentation regarding a component relevant to
/// describe the collection, computation, use, etc. of a data point or data
/// series, e.g., software, algorithm, study protocol, etc.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/header-1.0.json">header</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ExternalDatasheet {
  /// The type of component described or documented by the referenced
  /// datasheet, e.g., software, hardware, study.
  String? datasheetType;

  /// International Resource Identifier (IRI) of the datasheet.
  String datasheetReference;

  ExternalDatasheet({required this.datasheetReference, this.datasheetType});

  factory ExternalDatasheet.fromJson(Map<String, dynamic> json) =>
      _$ExternalDatasheetFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalDatasheetToJson(this);
}

/// The modality whereby a measure is obtained, i.e., whether it was sensed by
/// a device or application, or whether it was reported by a person.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/header-1.0.json">header</a>
class DataPointModality {
  static const String SENSED = 'sensed';
  static const String SELF_REPORTED = 'self-reported';
}
