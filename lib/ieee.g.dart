// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ieee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPoint _$DataPointFromJson(Map<String, dynamic> json) => DataPoint._(
  DataPointHeader.fromJson(json['header'] as Map<String, dynamic>),
  Measure.fromJson(json['body'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataPointToJson(DataPoint instance) => <String, dynamic>{
  'header': instance.header,
  'body': instance.body,
};

DataPointHeader _$DataPointHeaderFromJson(Map<String, dynamic> json) =>
    DataPointHeader(
      uuid: json['uuid'] as String,
      schemaId: SchemaId.fromJson(json['schema_id'] as Map<String, dynamic>),
      sourceCreationDateTime: DateTime.parse(
        json['source_creation_date_time'] as String,
      ),
      modality: json['modality'] as String?,
      acquisitionRate: json['acquisition_rate'] == null
          ? null
          : FrequencyUnitValue.fromJson(
              json['acquisition_rate'] as Map<String, dynamic>,
            ),
      externalDatasheets: (json['external_datasheets'] as List<dynamic>?)
          ?.map((e) => ExternalDatasheet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPointHeaderToJson(DataPointHeader instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'schema_id': instance.schemaId,
      'source_creation_date_time': instance.sourceCreationDateTime
          .toIso8601String(),
      'modality': ?instance.modality,
      'acquisition_rate': ?instance.acquisitionRate,
      'external_datasheets': ?instance.externalDatasheets,
    };

ExternalDatasheet _$ExternalDatasheetFromJson(Map<String, dynamic> json) =>
    ExternalDatasheet(
      datasheetReference: json['datasheet_reference'] as String,
      datasheetType: json['datasheet_type'] as String?,
    );

Map<String, dynamic> _$ExternalDatasheetToJson(ExternalDatasheet instance) =>
    <String, dynamic>{
      'datasheet_type': ?instance.datasheetType,
      'datasheet_reference': instance.datasheetReference,
    };

PhysicalActivity _$PhysicalActivityFromJson(
  Map<String, dynamic> json,
) => PhysicalActivity(
  activityName: json['activity_name'] as String,
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  baseMovementQuantity: json['base_movement_quantity'] == null
      ? null
      : UnitValue.fromJson(
          json['base_movement_quantity'] as Map<String, dynamic>,
        ),
  distance: json['distance'] == null
      ? null
      : LengthUnitValue.fromJson(json['distance'] as Map<String, dynamic>),
  cumulativeElevationGain: json['cumulative_elevation_gain'] == null
      ? null
      : LengthUnitValue.fromJson(
          json['cumulative_elevation_gain'] as Map<String, dynamic>,
        ),
  duration: json['duration'] == null
      ? null
      : DurationUnitValue.fromJson(json['duration'] as Map<String, dynamic>),
  durationLightActivity: json['duration_light_activity'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['duration_light_activity'] as Map<String, dynamic>,
        ),
  durationModerateActivity: json['duration_moderate_activity'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['duration_moderate_activity'] as Map<String, dynamic>,
        ),
  durationVigorousActivity: json['duration_vigorous_activity'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['duration_vigorous_activity'] as Map<String, dynamic>,
        ),
  averageCadence: json['average_cadence'] == null
      ? null
      : UnitValue.fromJson(json['average_cadence'] as Map<String, dynamic>),
  averageSpeed: json['average_speed'] == null
      ? null
      : SpeedUnitValue.fromJson(json['average_speed'] as Map<String, dynamic>),
  kcalBurned: json['kcal_burned'] == null
      ? null
      : KcalUnitValue.fromJson(json['kcal_burned'] as Map<String, dynamic>),
  reportedActivityIntensity: json['reported_activity_intensity'] as String?,
  metValue: (json['met_value'] as num?)?.toDouble(),
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$PhysicalActivityToJson(PhysicalActivity instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'activity_name': instance.activityName,
      'base_movement_quantity': ?instance.baseMovementQuantity,
      'distance': ?instance.distance,
      'cumulative_elevation_gain': ?instance.cumulativeElevationGain,
      'duration': ?instance.duration,
      'duration_light_activity': ?instance.durationLightActivity,
      'duration_moderate_activity': ?instance.durationModerateActivity,
      'duration_vigorous_activity': ?instance.durationVigorousActivity,
      'average_cadence': ?instance.averageCadence,
      'average_speed': ?instance.averageSpeed,
      'kcal_burned': ?instance.kcalBurned,
      'reported_activity_intensity': ?instance.reportedActivityIntensity,
      'met_value': ?instance.metValue,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

Survey _$SurveyFromJson(Map<String, dynamic> json) =>
    Survey(
        items: (json['items'] as List<dynamic>)
            .map((e) => SurveyItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        deliveryDetails: SurveyDeliveryDetails.fromJson(
          json['delivery_details'] as Map<String, dynamic>,
        ),
        score: json['score'],
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'items': instance.items,
  'delivery_details': instance.deliveryDetails,
  'score': ?instance.score,
};

SurveyDeliveryDetails _$SurveyDeliveryDetailsFromJson(
  Map<String, dynamic> json,
) => SurveyDeliveryDetails(
  startDateTime: json['start_date_time'] == null
      ? null
      : DateTime.parse(json['start_date_time'] as String),
  endDateTime: json['end_date_time'] == null
      ? null
      : DateTime.parse(json['end_date_time'] as String),
  endStatus: json['end_status'] as String?,
);

Map<String, dynamic> _$SurveyDeliveryDetailsToJson(
  SurveyDeliveryDetails instance,
) => <String, dynamic>{
  'start_date_time': ?instance.startDateTime?.toIso8601String(),
  'end_date_time': ?instance.endDateTime?.toIso8601String(),
  'end_status': ?instance.endStatus,
};

SurveyItem _$SurveyItemFromJson(Map<String, dynamic> json) => SurveyItem(
  question: SurveyQuestion.fromJson(json['question'] as Map<String, dynamic>),
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => SurveyAnswer.fromJson(e as Map<String, dynamic>))
      .toList(),
  askedDateTime: json['asked_date_time'] == null
      ? null
      : DateTime.parse(json['asked_date_time'] as String),
  answeredDateTime: json['answered_date_time'] == null
      ? null
      : DateTime.parse(json['answered_date_time'] as String),
);

Map<String, dynamic> _$SurveyItemToJson(SurveyItem instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answers': instance.answers,
      'asked_date_time': ?instance.askedDateTime?.toIso8601String(),
      'answered_date_time': ?instance.answeredDateTime?.toIso8601String(),
    };

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    SurveyQuestion(
      text: json['text'] as String,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{'text': instance.text, 'label': ?instance.label};

SurveyAnswer _$SurveyAnswerFromJson(Map<String, dynamic> json) =>
    SurveyAnswer(value: json['value'] as Object);

Map<String, dynamic> _$SurveyAnswerToJson(SurveyAnswer instance) =>
    <String, dynamic>{'value': instance.value};

SurveyCategoricalAnswer _$SurveyCategoricalAnswerFromJson(
  Map<String, dynamic> json,
) =>
    SurveyCategoricalAnswer(value: json['value'] as Object, code: json['code']);

Map<String, dynamic> _$SurveyCategoricalAnswerToJson(
  SurveyCategoricalAnswer instance,
) => <String, dynamic>{'value': instance.value, 'code': ?instance.code};

SurveyDateAnswer _$SurveyDateAnswerFromJson(Map<String, dynamic> json) =>
    SurveyDateAnswer(value: json['value'] as String);

Map<String, dynamic> _$SurveyDateAnswerToJson(SurveyDateAnswer instance) =>
    <String, dynamic>{'value': instance.value};

SurveyTimeAnswer _$SurveyTimeAnswerFromJson(Map<String, dynamic> json) =>
    SurveyTimeAnswer(value: json['value'] as String);

Map<String, dynamic> _$SurveyTimeAnswerToJson(SurveyTimeAnswer instance) =>
    <String, dynamic>{'value': instance.value};

SurveyUnitValueAnswer _$SurveyUnitValueAnswerFromJson(
  Map<String, dynamic> json,
) => SurveyUnitValueAnswer(
  value: UnitValue.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SurveyUnitValueAnswerToJson(
  SurveyUnitValueAnswer instance,
) => <String, dynamic>{'value': instance.value};

SpeedUnitValue _$SpeedUnitValueFromJson(Map<String, dynamic> json) =>
    SpeedUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$SpeedUnitValueToJson(SpeedUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

FrequencyUnitValue _$FrequencyUnitValueFromJson(Map<String, dynamic> json) =>
    FrequencyUnitValue(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      numberOfTimes: (json['number_of_times'] as num?)?.toDouble(),
      timeWindow: json['time_window'] == null
          ? null
          : DurationUnitValue.fromJson(
              json['time_window'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FrequencyUnitValueToJson(FrequencyUnitValue instance) =>
    <String, dynamic>{
      'value': ?instance.value,
      'unit': ?instance.unit,
      'number_of_times': ?instance.numberOfTimes,
      'time_window': ?instance.timeWindow,
    };
