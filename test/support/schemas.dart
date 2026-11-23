/// The IEEE 1752.1 and OMH schemas supported by this package, with the
/// version implemented and how to read them from JSON.
library;

import 'package:openmhealth_schemas/openmhealth_schemas.dart';
import 'package:test/test.dart';

import 'round_trip.dart';

/// A schema supported by this package.
class SupportedSchema {
  /// The version of the schema implemented by this package.
  final SchemaVersion version;

  /// Reads a JSON value of this schema.
  final JsonParser parse;

  /// The allowed values, if this is an enumeration schema.
  final Set<String>? values;

  SupportedSchema(this.version, this.parse) : values = null;

  /// An enumeration schema with the allowed [values].
  SupportedSchema.enumeration(this.version, Set<String> this.values)
    : parse = _enumParser(values);

  /// A schema represented by a JSON object, read by [fromJson].
  static SupportedSchema object(
    SchemaVersion version,
    Object Function(Map<String, dynamic>) fromJson,
  ) => SupportedSchema(version, (json) => fromJson(json as Map<String, dynamic>));

  /// A schema represented by a JSON object, with the version of [schemaId].
  static SupportedSchema ofId(
    SchemaId schemaId,
    Object Function(Map<String, dynamic>) fromJson,
  ) => object(schemaId.schemaVersion, fromJson);

  static JsonParser _enumParser(Set<String> values) => (json) {
    expect(values, contains(json), reason: 'Not a known value: $json');
    return json!;
  };
}

/// Reads a date-time string.
Object _dateTime(Object? json) =>
    DateTime.parse(json as String).toIso8601String();

/// The IEEE 1752.1 schemas, by schema name.
final Map<String, SupportedSchema> ieeeSchemas = {
  // metadata
  'data-point': SupportedSchema.ofId(DataPoint.SCHEMA_ID, DataPoint.fromJson),
  'data-series': SupportedSchema.ofId(
    DataSeries.SCHEMA_ID,
    DataSeries.fromJson,
  ),
  'header': SupportedSchema.ofId(
    DataPointHeader.SCHEMA_ID,
    DataPointHeader.fromJson,
  ),
  'schema-id': SupportedSchema.ofId(SchemaId.SCHEMA_ID, SchemaId.fromJson),

  // physical activity
  'physical-activity': SupportedSchema.ofId(
    PhysicalActivity.SCHEMA_ID,
    PhysicalActivity.fromJson,
  ),

  // sleep
  'apnea-hypopnea-index': SupportedSchema.ofId(
    ApneaHypopneaIndex.SCHEMA_ID,
    ApneaHypopneaIndex.fromJson,
  ),
  'arousal-index': SupportedSchema.ofId(
    ArousalIndex.SCHEMA_ID,
    ArousalIndex.fromJson,
  ),
  'deep-sleep': SupportedSchema.ofId(DeepSleep.SCHEMA_ID, DeepSleep.fromJson),
  'light-sleep': SupportedSchema.ofId(
    LightSleep.SCHEMA_ID,
    LightSleep.fromJson,
  ),
  'sleep-episode': SupportedSchema.ofId(
    SleepEpisode.SCHEMA_ID,
    SleepEpisode.fromJson,
  ),
  'sleep-onset-latency': SupportedSchema.ofId(
    SleepOnsetLatency.SCHEMA_ID,
    SleepOnsetLatency.fromJson,
  ),
  'sleep-stage-summary': SupportedSchema.ofId(
    SleepStageSummary.SCHEMA_ID,
    SleepStageSummary.fromJson,
  ),
  'snore-index': SupportedSchema.ofId(
    SnoreIndex.SCHEMA_ID,
    SnoreIndex.fromJson,
  ),
  'time-in-bed': SupportedSchema.ofId(TimeInBed.SCHEMA_ID, TimeInBed.fromJson),
  'total-sleep-time': SupportedSchema.ofId(
    TotalSleepTime.SCHEMA_ID,
    TotalSleepTime.fromJson,
  ),
  'wake-after-sleep-onset': SupportedSchema.ofId(
    WakeAfterSleepOnset.SCHEMA_ID,
    WakeAfterSleepOnset.fromJson,
  ),

  // environment
  'ambient-light': SupportedSchema.ofId(
    AmbientLight.SCHEMA_ID,
    AmbientLight.fromJson,
  ),
  'ambient-sound': SupportedSchema.ofId(
    AmbientSound.SCHEMA_ID,
    AmbientSound.fromJson,
  ),
  'ambient-temperature': SupportedSchema.ofId(
    AmbientTemperature.SCHEMA_ID,
    AmbientTemperature.fromJson,
  ),

  // survey
  'survey': SupportedSchema.ofId(Survey.SCHEMA_ID, Survey.fromJson),
  'survey-item': SupportedSchema.ofId(
    SurveyItem.SCHEMA_ID,
    SurveyItem.fromJson,
  ),
  'survey-question': SupportedSchema.ofId(
    SurveyQuestion.SCHEMA_ID,
    SurveyQuestion.fromJson,
  ),
  'survey-answer': SupportedSchema.ofId(
    SurveyAnswer.SCHEMA_ID,
    SurveyAnswer.fromJson,
  ),
  'survey-categorical-answer': SupportedSchema.ofId(
    SurveyCategoricalAnswer.SCHEMA_ID,
    SurveyCategoricalAnswer.fromJson,
  ),
  'survey-date-answer': SupportedSchema.ofId(
    SurveyDateAnswer.SCHEMA_ID,
    SurveyDateAnswer.fromJson,
  ),
  'survey-time-answer': SupportedSchema.ofId(
    SurveyTimeAnswer.SCHEMA_ID,
    SurveyTimeAnswer.fromJson,
  ),
  'survey-unit-value-answer': SupportedSchema.ofId(
    SurveyUnitValueAnswer.SCHEMA_ID,
    SurveyUnitValueAnswer.fromJson,
  ),

  // utility
  'date-time': SupportedSchema(SchemaVersion.V1_0, _dateTime),
  'body-posture': SupportedSchema.enumeration(SchemaVersion.V1_0, {
    BodyPosture.SITTING,
    BodyPosture.LYING_DOWN,
    BodyPosture.STANDING,
    BodyPosture.SEMI_RECUMBENT,
  }),
  'descriptive-statistic': SupportedSchema.enumeration(SchemaVersion.V1_0, {
    DescriptiveStatistic.AVERAGE,
    DescriptiveStatistic.COUNT,
    DescriptiveStatistic.MAXIMUM,
    DescriptiveStatistic.MEDIAN,
    DescriptiveStatistic.MINIMUM,
    DescriptiveStatistic.STANDARD_DEVIATION,
    DescriptiveStatistic.SUM,
    DescriptiveStatistic.VARIANCE,
    DescriptiveStatistic.PERCENTILE_20TH,
    DescriptiveStatistic.PERCENTILE_80TH,
    DescriptiveStatistic.LOWER_QUARTILE,
    DescriptiveStatistic.UPPER_QUARTILE,
    DescriptiveStatistic.QUARTILE_DEVIATION,
    DescriptiveStatistic.QUINTILE_1ST,
    DescriptiveStatistic.QUINTILE_2ND,
    DescriptiveStatistic.QUINTILE_3RD,
    DescriptiveStatistic.QUINTILE_4TH,
  }),
  'descriptive-statistic-denominator': SupportedSchema.enumeration(
    SchemaVersion.V1_0,
    {
      DescriptiveStatisticDenominator.DAY,
      DescriptiveStatisticDenominator.WEEK,
      DescriptiveStatisticDenominator.MONTH,
      DescriptiveStatisticDenominator.EPISODE,
      DescriptiveStatisticDenominator.MEAL,
      DescriptiveStatisticDenominator.SESSION,
    },
  ),
  'unit-value': SupportedSchema.ofId(UnitValue.SCHEMA_ID, UnitValue.fromJson),
  'unit-value-range': SupportedSchema.ofId(
    UnitValueRange.SCHEMA_ID,
    UnitValueRange.fromJson,
  ),
  'duration-unit-value': SupportedSchema.ofId(
    DurationUnitValue.SCHEMA_ID,
    DurationUnitValue.fromJson,
  ),
  'duration-unit-value-range': SupportedSchema.ofId(
    DurationUnitValueRange.SCHEMA_ID,
    DurationUnitValueRange.fromJson,
  ),
  'frequency-unit-value': SupportedSchema.ofId(
    FrequencyUnitValue.SCHEMA_ID,
    FrequencyUnitValue.fromJson,
  ),
  'illuminance-unit-value': SupportedSchema.ofId(
    IlluminanceUnitValue.SCHEMA_ID,
    IlluminanceUnitValue.fromJson,
  ),
  'kcal-unit-value': SupportedSchema.ofId(
    KcalUnitValue.SCHEMA_ID,
    KcalUnitValue.fromJson,
  ),
  'length-unit-value': SupportedSchema.ofId(
    LengthUnitValue.SCHEMA_ID,
    LengthUnitValue.fromJson,
  ),
  'percent-unit-value': SupportedSchema.ofId(
    PercentUnitValue.SCHEMA_ID,
    PercentUnitValue.fromJson,
  ),
  'sound-unit-value': SupportedSchema.ofId(
    SoundUnitValue.SCHEMA_ID,
    SoundUnitValue.fromJson,
  ),
  'speed-unit-value': SupportedSchema.ofId(
    SpeedUnitValue.SCHEMA_ID,
    SpeedUnitValue.fromJson,
  ),
  'temperature-unit-value': SupportedSchema.ofId(
    TemperatureUnitValue.SCHEMA_ID,
    TemperatureUnitValue.fromJson,
  ),
  'time-frame': SupportedSchema.ofId(TimeFrame.SCHEMA_ID, TimeFrame.fromJson),
  'time-interval': SupportedSchema.ofId(
    TimeInterval.SCHEMA_ID,
    TimeInterval.fromJson,
  ),
};

/// The OMH schemas, by schema name.
final Map<String, SupportedSchema> omhSchemas = {
  'acceleration': SupportedSchema.ofId(
    Acceleration.SCHEMA_ID,
    Acceleration.fromJson,
  ),
  'acceleration-unit-value': SupportedSchema.ofId(
    AccelerationUnitValue.SCHEMA_ID,
    AccelerationUnitValue.fromJson,
  ),
  'blood-pressure': SupportedSchema.ofId(
    BloodPressure.SCHEMA_ID,
    BloodPressure.fromJson,
  ),
  'systolic-blood-pressure': SupportedSchema.ofId(
    SystolicBloodPressure.SCHEMA_ID,
    SystolicBloodPressure.fromJson,
  ),
  'diastolic-blood-pressure': SupportedSchema.ofId(
    DiastolicBloodPressure.SCHEMA_ID,
    DiastolicBloodPressure.fromJson,
  ),
  'calories-burned': SupportedSchema.ofId(
    CaloriesBurned.SCHEMA_ID,
    CaloriesBurned.fromJson,
  ),
  'geoposition': SupportedSchema.ofId(
    Geoposition.SCHEMA_ID,
    Geoposition.fromJson,
  ),
  'plane-angle-unit-value': SupportedSchema.ofId(
    PlaneAngleUnitValue.SCHEMA_ID,
    PlaneAngleUnitValue.fromJson,
  ),
  'heart-rate': SupportedSchema.ofId(HeartRate.SCHEMA_ID, HeartRate.fromJson),
  'rr-interval': SupportedSchema.ofId(
    RrInterval.SCHEMA_ID,
    RrInterval.fromJson,
  ),
  'body-location': SupportedSchema.enumeration(SchemaVersion.V1_1, {
    BodyLocation.LEFT_ANKLE,
    BodyLocation.RIGHT_ANKLE,
    BodyLocation.LEFT_HIP,
    BodyLocation.RIGHT_HIP,
    BodyLocation.LEFT_THIGH,
    BodyLocation.RIGH_THIGH,
    BodyLocation.LEFT_THORAX,
    BodyLocation.MIDDLE_LEFT_THORAX,
    BodyLocation.LEFT_UPPER_ARM,
    BodyLocation.RIGHT_UPPER_ARM,
    BodyLocation.LEFT_WRIST,
    BodyLocation.RIGHT_WRIST,
  }),
  'temporal-relationship-to-physical-activity': SupportedSchema.enumeration(
    SchemaVersion.V1_0,
    {
      TemporalRelationshipToPhysicalActivity.AT_REST,
      TemporalRelationshipToPhysicalActivity.ACTIVE,
      TemporalRelationshipToPhysicalActivity.BEFORE_EXERCISE,
      TemporalRelationshipToPhysicalActivity.AFTER_EXERCISE,
      TemporalRelationshipToPhysicalActivity.DURING_EXERCISE,
    },
  ),
  'temporal-relationship-to-sleep': SupportedSchema.enumeration(
    SchemaVersion.V1_0,
    {
      TemporalRelationshipToSleep.BEFORE_SLEEPING,
      TemporalRelationshipToSleep.DURING_SLEEPING,
      TemporalRelationshipToSleep.ON_WAKING,
    },
  ),
  'temporal-relationship-to-meal': SupportedSchema.enumeration(
    SchemaVersion.V1_2,
    {
      TemporalRelationshipToMeal.FASTING,
      TemporalRelationshipToMeal.NOT_FASTING,
      TemporalRelationshipToMeal.BEFORE_MEAL,
      TemporalRelationshipToMeal.AFTER_MEAL,
      TemporalRelationshipToMeal.BEORE_BREAKFAST,
      TemporalRelationshipToMeal.AFTER_BREAKFAST,
      TemporalRelationshipToMeal.BEFORE_LUNCH,
      TemporalRelationshipToMeal.AFTER_LUNCH,
      TemporalRelationshipToMeal.BEFORE_DINNER,
      TemporalRelationshipToMeal.AFTER_DINNER,
      TemporalRelationshipToMeal.TWO_HOURS_POST_PRANDIAL,
      TemporalRelationshipToMeal.WITH_MEAL,
      TemporalRelationshipToMeal.WITH_FOOD,
    },
  ),
  'part-of-day': SupportedSchema.enumeration(SchemaVersion.V1_0, {
    PartOfDay.MORNING,
    PartOfDay.AFTERNOON,
    PartOfDay.EVENING,
    PartOfDay.NIGHT,
  }),
  'day-of-week': SupportedSchema.enumeration(SchemaVersion.V1_0, {
    DayOfWeek.MONDAY,
    DayOfWeek.TUESDAY,
    DayOfWeek.WEDNESDAY,
    DayOfWeek.THURSDAY,
    DayOfWeek.FRIDAY,
    DayOfWeek.SATURDAY,
    DayOfWeek.SUNDAY,
  }),
};

/// The name and version of a schema file name such as `deep-sleep-1.0.json`.
({String name, String version})? schemaFileName(String path) {
  final match = RegExp(
    r'([a-z0-9-]+)-(\d+\.\d+)\.json$',
  ).firstMatch(path.split('/').last);
  return match == null ? null : (name: match[1]!, version: match[2]!);
}

/// Compares two versions such as `1.2` and `3.0`.
int compareVersions(String a, String b) =>
    SchemaVersion.fromString(a).compareTo(SchemaVersion.fromString(b));
