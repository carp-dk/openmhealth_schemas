part of '../../openmhealth_schemas.dart';

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

  /// See [DescriptiveStatisticDenominator].
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
