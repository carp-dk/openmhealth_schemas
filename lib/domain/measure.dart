part of '../openmhealth_schemas.dart';

/// The base class for all IEEE 1752.1 and OMH measures, i.e., the schemas that
/// can be used as the body of a [DataPoint] or [DataSeries].
///
/// A measure only holds the properties defined by its schema. Additional
/// properties in JSON (which the IEEE 1752.1 and OMH schemas allow) are
/// ignored when a measure is read from JSON, and are hence not kept.
///
/// To add properties of your own, define your own measure in your own
/// namespace by extending this class, and register it in the
/// [MeasureFactory] so it can be read as the body of a [DataPoint]:
///
/// ```dart
/// MeasureFactory.register(MyMeasure.SCHEMA_ID, MyMeasure.fromJson);
/// ```
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Measure implements SchemaSupport {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(
      SchemaSupport.OMH_NAMESPACE, SchemaSupport.MEASURE, SchemaVersion.V1_0);

  TimeFrame? effectiveTimeFrame;
  String? descriptiveStatistic;
  String? userNotes;

  Measure({
    this.effectiveTimeFrame,
    this.descriptiveStatistic,
    this.userNotes,
  }) : super();

  factory Measure.fromJson(Map<String, dynamic> json) =>
      _$MeasureFromJson(json);

  Map<String, dynamic> toJson() => _$MeasureToJson(this);

  @override
  SchemaId getSchemaId() {
    return SCHEMA_ID;
  }
}
