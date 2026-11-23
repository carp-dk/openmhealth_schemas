part of '../../openmhealth_schemas.dart';

/// This schema represents a single episode of [physical activity](http://bioportal.bioontology.org/ontologies/SNOMEDCT?p=classes&conceptid=68130003),
/// including the name of the activity, duration, distance, intensity and calories burned.
///
/// OMH version 1.2
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_physical-activity">physical-activity</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PhysicalActivity extends Measure {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(
      SchemaSupport.OMH_NAMESPACE, SchemaSupport.ACTIVITY, SchemaVersion.V1_2);

  String activityName;

  /// The Metabolic Equivalent of Task (MET) value for the activity.
  double? metValue;
  LengthUnitValue? distance;
  String? reportedActivityIntensity;

  /// The calories burned during the activity.
  ///
  /// Serialized as `kcal_burned` as defined in OMH. For backward compatibility,
  /// the (incorrect) `calories_burned` used in earlier versions of this
  /// package is also accepted when reading JSON.
  @JsonKey(name: 'kcal_burned', readValue: _readKcalBurned)
  KcalUnitValue? caloriesBurned;

  static Object? _readKcalBurned(Map<dynamic, dynamic> json, String key) =>
      json[key] ?? json['calories_burned'];

  /// Creates a [PhysicalActivity].
  /// The [activityName] is required according to the OMH definition.
  PhysicalActivity({
    required this.activityName,
    this.distance,
    this.reportedActivityIntensity,
    this.caloriesBurned,
    this.metValue,
  });

  factory PhysicalActivity.fromJson(Map<String, dynamic> json) =>
      _$PhysicalActivityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PhysicalActivityToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// Self-reported intensity of a [PhysicalActivity].
///
/// OMH version 1.2
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_physical-activity">physical-activity</a>
class SelfReportedIntensity {
  static const String LIGHT = 'light';
  static const String MODERATE = 'moderate';
  static const String VIGOROUS = 'vigorous';
}

/// A unit of kilo-calories.
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_kcal-unit-value">kcal-unit-value</a>
class KcalUnit extends Unit {
  static const String KILOCALORIE = 'kcal';

  KcalUnit(super.schemaValue);
}

/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_kcal-unit-value">kcal-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class KcalUnitValue extends UnitValue {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(
      SchemaSupport.OMH_NAMESPACE, 'kcal-unit-value', SchemaVersion.V1_0);

  KcalUnitValue({
    required String unit,
    required double value,
  }) : super(unit, value);

  factory KcalUnitValue.fromJson(Map<String, dynamic> json) =>
      _$KcalUnitValueFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KcalUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents [number of steps](http://bioportal.bioontology.org/ontologies/LOINC?p=classes&conceptid=55423-8).
///
/// OMH version 3.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_step-count">step-count</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class StepCount extends Measure {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(SchemaSupport.OMH_NAMESPACE,
      SchemaSupport.STEP_COUNT, SchemaVersion.V3_0);

  /// The number of steps.
  ///
  /// In OMH 3.0, this is serialized as a unit value, e.g.
  /// `{"value": 7939, "unit": "steps"}`. For backward compatibility, the plain
  /// number used in OMH 2.0 is also accepted when reading JSON.
  @JsonKey(fromJson: _stepCountFromJson, toJson: _stepCountToJson)
  int stepCount;

  static int _stepCountFromJson(Object? json) => switch (json) {
    num n => n.toInt(),
    {'value': num n} => n.toInt(),
    _ => throw FormatException('Invalid step_count: $json'),
  };

  static Map<String, dynamic> _stepCountToJson(int stepCount) =>
      {'value': stepCount, 'unit': StepCountUnit.STEPS};
  String? descriptiveStatisticDenominator;

  /// Creates a [StepCount]. The [stepCount] is required according to the OMH definition.
  StepCount({
    required this.stepCount,
    this.descriptiveStatisticDenominator,
  });

  factory StepCount.fromJson(Map<String, dynamic> json) =>
      _$StepCountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StepCountToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The unit of a [StepCount].
///
/// OMH version 3.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_step-count">step-count</a>
class StepCountUnit extends Unit {
  static const String STEPS = 'steps';

  StepCountUnit(super.schemaValue);
}

/// This schema represents the amount of [calories burned](http://bioportal.bioontology.org/ontologies/LOINC?p=classes&conceptid=41981-2) in kilocalories (kcal).
///
/// OMH version 3.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_calories-burned">calories-burned</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CaloriesBurned extends Measure {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(
      SchemaSupport.OMH_NAMESPACE, SchemaSupport.CALORIES, SchemaVersion.V3_0);

  KcalUnitValue kcalBurned;
  String? activityName;
  String? descriptiveStatisticDenominator;

  /// Creates a [CaloriesBurned]. The [kcalBurned] is required according to the OMH definition.
  CaloriesBurned({
    required this.kcalBurned,
    this.activityName,
    this.descriptiveStatisticDenominator,
  });

  factory CaloriesBurned.fromJson(Map<String, dynamic> json) =>
      _$CaloriesBurnedFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CaloriesBurnedToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A measurement of minutes of moderate-intensity activity performed.
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_minutes-moderate-activity">minutes-moderate-activity</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class MinutesModerateActivity extends Measure {
  static SchemaId SCHEMA_ID = SchemaId.withVersion(SchemaSupport.OMH_NAMESPACE,
      SchemaSupport.MINUTES_MODERATE_ACTIVITY, SchemaVersion.V1_0);

  DurationUnitValue minutesModerateActivity;

  /// Creates a [MinutesModerateActivity]. The [minutesModerateActivity] is required according to the OMH definition.
  MinutesModerateActivity({required this.minutesModerateActivity});

  factory MinutesModerateActivity.fromJson(Map<String, dynamic> json) =>
      _$MinutesModerateActivityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MinutesModerateActivityToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
