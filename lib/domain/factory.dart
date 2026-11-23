part of '../openmhealth_schemas.dart';

/// A function that creates a [Measure] from its JSON representation.
typedef MeasureFromJson = Measure Function(Map<String, dynamic> json);

/// A registry of `fromJson` functions for [Measure]s, keyed by the schema
/// identifier of the measure.
///
/// This is used to deserialize the body of a [DataPoint] or [DataSeries]. The
/// type of the body is identified by the [DataPointHeader.schemaId] of the
/// header, as defined by IEEE 1752.1. Hence, no type information needs to be
/// added to the JSON.
///
/// All measures in this package are registered by default. Measures defined
/// outside this package (e.g., in another namespace) can be added using
/// [register]:
///
/// ```dart
/// MeasureFactory.register(MyMeasure.SCHEMA_ID, MyMeasure.fromJson);
/// ```
///
/// Measures are looked up by the namespace and name of their schema id. The
/// version is ignored, so data using a different version of a schema is read
/// using the registered measure for that schema.
class MeasureFactory {
  MeasureFactory._();

  static final Map<String, MeasureFromJson> _registry = {
    for (final (schemaId, fromJson) in <(SchemaId, MeasureFromJson)>[
      // IEEE 1752.1
      (PhysicalActivity.SCHEMA_ID, PhysicalActivity.fromJson),
      (Survey.SCHEMA_ID, Survey.fromJson),
      (ApneaHypopneaIndex.SCHEMA_ID, ApneaHypopneaIndex.fromJson),
      (ArousalIndex.SCHEMA_ID, ArousalIndex.fromJson),
      (DeepSleep.SCHEMA_ID, DeepSleep.fromJson),
      (LightSleep.SCHEMA_ID, LightSleep.fromJson),
      (SleepEpisode.SCHEMA_ID, SleepEpisode.fromJson),
      (SleepOnsetLatency.SCHEMA_ID, SleepOnsetLatency.fromJson),
      (SleepStageSummary.SCHEMA_ID, SleepStageSummary.fromJson),
      (SnoreIndex.SCHEMA_ID, SnoreIndex.fromJson),
      (TimeInBed.SCHEMA_ID, TimeInBed.fromJson),
      (TotalSleepTime.SCHEMA_ID, TotalSleepTime.fromJson),
      (WakeAfterSleepOnset.SCHEMA_ID, WakeAfterSleepOnset.fromJson),
      (AmbientLight.SCHEMA_ID, AmbientLight.fromJson),
      (AmbientSound.SCHEMA_ID, AmbientSound.fromJson),
      (AmbientTemperature.SCHEMA_ID, AmbientTemperature.fromJson),
      // OMH
      (Acceleration.SCHEMA_ID, Acceleration.fromJson),
      (BloodPressure.SCHEMA_ID, BloodPressure.fromJson),
      (CaloriesBurned.SCHEMA_ID, CaloriesBurned.fromJson),
      (Geoposition.SCHEMA_ID, Geoposition.fromJson),
      (HeartRate.SCHEMA_ID, HeartRate.fromJson),
      (RrInterval.SCHEMA_ID, RrInterval.fromJson),
    ])
      _key(schemaId): fromJson,
  };

  static String _key(SchemaId schemaId) =>
      '${schemaId.namespace}.${schemaId.name}';

  /// Registers the [fromJson] function for measures with the schema id
  /// [schemaId]. Any existing registration for this schema is replaced.
  static void register(SchemaId schemaId, MeasureFromJson fromJson) =>
      _registry[_key(schemaId)] = fromJson;

  /// Is a `fromJson` function registered for [schemaId]?
  static bool isRegistered(SchemaId schemaId) =>
      _registry.containsKey(_key(schemaId));

  /// Creates a [Measure] with the schema id [schemaId] from [json].
  ///
  /// If no `fromJson` function is registered for [schemaId], a
  /// [GenericMeasure] holding the original JSON is returned, so that no data
  /// is lost.
  static Measure fromJson(SchemaId schemaId, Map<String, dynamic> json) =>
      _registry[_key(schemaId)]?.call(json) ?? GenericMeasure(schemaId, json);
}

/// A measure of a schema for which no `fromJson` function is registered in
/// the [MeasureFactory].
///
/// A [GenericMeasure] holds the original JSON of the measure in [json], and
/// [toJson] returns this JSON unchanged. The common measure properties (e.g.,
/// [effectiveTimeFrame]) are read from the JSON for convenience, but changing
/// them does not change the JSON.
class GenericMeasure extends Measure {
  /// The schema id of this measure.
  final SchemaId schemaId;

  /// The original JSON of this measure.
  final Map<String, dynamic> json;

  GenericMeasure(this.schemaId, this.json)
    : super(
        effectiveTimeFrame: json['effective_time_frame'] is Map<String, dynamic>
            ? TimeFrame.fromJson(
                json['effective_time_frame'] as Map<String, dynamic>,
              )
            : null,
        descriptiveStatistic: json['descriptive_statistic'] as String?,
        userNotes: json['user_notes'] as String?,
      );

  @override
  Map<String, dynamic> toJson() => json;

  @override
  SchemaId getSchemaId() => schemaId;
}
