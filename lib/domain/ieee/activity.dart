part of '../../openmhealth_schemas.dart';

/// This schema represents episode(s) of physical activity.
///
/// Compared to OMH, IEEE 1752.1 requires an [effectiveTimeFrame] which must be
/// a time interval, renames `calories_burned` to [kcalBurned], and adds a
/// number of properties such as [duration], [averageSpeed], and [metValue].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/physical_activity/physical-activity-1.0.json">physical-activity</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PhysicalActivity extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.ACTIVITY,
    SchemaVersion.V1_0,
  );

  /// The name of the physical activity in which the person is engaged.
  /// This can be sedentary.
  String activityName;

  /// Number of repetitions of the activity base movement, if applicable
  /// (e.g., if activity is walking, this would be the number of steps).
  /// See [BaseMovementUnit].
  UnitValue? baseMovementQuantity;

  /// The distance covered, if applicable.
  LengthUnitValue? distance;

  /// The total ascent, if applicable.
  LengthUnitValue? cumulativeElevationGain;

  /// The net duration of the activity.
  DurationUnitValue? duration;

  /// The duration of light-intensity physical activity.
  DurationUnitValue? durationLightActivity;

  /// The duration of moderate-intensity physical activity.
  DurationUnitValue? durationModerateActivity;

  /// The duration of vigorous-intensity physical activity.
  DurationUnitValue? durationVigorousActivity;

  /// The average rate at which the activity was performed, if applicable.
  /// See [CadenceUnit].
  UnitValue? averageCadence;

  /// The average speed at which the activity was performed, if applicable.
  SpeedUnitValue? averageSpeed;

  /// The calories burned during the activity.
  KcalUnitValue? kcalBurned;

  /// Self-reported intensity of the activity performed.
  /// See [SelfReportedIntensity].
  String? reportedActivityIntensity;

  /// Average Metabolic Equivalent of Task (MET) value for the activity.
  double? metValue;

  /// The denominator of the descriptive statistic when the measure has an
  /// implicit duration. See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  /// Creates a [PhysicalActivity]. The [activityName] and [effectiveTimeFrame]
  /// are required, and the [effectiveTimeFrame] must be a time interval.
  PhysicalActivity({
    required this.activityName,
    required TimeFrame super.effectiveTimeFrame,
    this.baseMovementQuantity,
    this.distance,
    this.cumulativeElevationGain,
    this.duration,
    this.durationLightActivity,
    this.durationModerateActivity,
    this.durationVigorousActivity,
    this.averageCadence,
    this.averageSpeed,
    this.kcalBurned,
    this.reportedActivityIntensity,
    this.metValue,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(
         effectiveTimeFrame.timeInterval != null,
         'The effective time frame of a physical activity must be a time interval.',
       );

  factory PhysicalActivity.fromJson(Map<String, dynamic> json) =>
      _$PhysicalActivityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PhysicalActivityToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// Self-reported intensity of a [PhysicalActivity].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/physical_activity/physical-activity-1.0.json">physical-activity</a>
class SelfReportedIntensity {
  static const String LIGHT = 'light';
  static const String MODERATE = 'moderate';
  static const String VIGOROUS = 'vigorous';
}

/// Units for the base movement quantity of a [PhysicalActivity].
/// Other units may be used if none of these apply.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/physical_activity/physical-activity-1.0.json">physical-activity</a>
class BaseMovementUnit extends Unit {
  static const String STEPS = 'steps';
  static const String LAPS = 'laps';
  static const String SKIPS = 'skips';
  static const String MOVEMENTS = 'movements';
  static const String STROKES = 'strokes';

  BaseMovementUnit(super.schemaValue);
}

/// Units for the average cadence of a [PhysicalActivity].
/// Other units may be used if none of these apply.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/physical_activity/physical-activity-1.0.json">physical-activity</a>
class CadenceUnit extends Unit {
  static const String STEPS_PER_MINUTE = 'steps/min';
  static const String STROKES_PER_MINUTE = 'strokes/min';
  static const String SKIPS_PER_MINUTE = 'skips/min';
  static const String LAPS_PER_MINUTE = 'laps/min';
  static const String MOVEMENTS_PER_MINUTE = 'movements/min';
  static const String STROKES_PER_LAP = 'strokes/lap';

  CadenceUnit(super.schemaValue);
}
