// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openmhealth_schemas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemaVersion _$SchemaVersionFromJson(Map<String, dynamic> json) =>
    SchemaVersion(
      major: (json['major'] as num?)?.toInt() ?? 1,
      minor: (json['minor'] as num?)?.toInt() ?? 0,
      qualifier: json['qualifier'] as String?,
    );

Map<String, dynamic> _$SchemaVersionToJson(SchemaVersion instance) =>
    <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
      'qualifier': ?instance.qualifier,
    };

Measure _$MeasureFromJson(Map<String, dynamic> json) => Measure(
  effectiveTimeFrame: json['effective_time_frame'] == null
      ? null
      : TimeFrame.fromJson(
          json['effective_time_frame'] as Map<String, dynamic>,
        ),
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  userNotes: json['user_notes'] as String?,
);

Map<String, dynamic> _$MeasureToJson(Measure instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
};

Map<String, dynamic> _$DataPointToJson(DataPoint instance) => <String, dynamic>{
  'header': instance.header,
  'body': instance.body,
};

Map<String, dynamic> _$DataSeriesToJson(DataSeries instance) =>
    <String, dynamic>{'header': instance.header, 'body': instance.body};

DataPointHeader _$DataPointHeaderFromJson(Map<String, dynamic> json) =>
    DataPointHeader(
      uuid: json['uuid'] as String,
      schemaId: SchemaId.fromJson(json['schema_id'] as Map<String, dynamic>),
      sourceCreationDateTime: const _UtcDateTimeConverter().fromJson(
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
      'source_creation_date_time': const _UtcDateTimeConverter().toJson(
        instance.sourceCreationDateTime,
      ),
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

UnitValue _$UnitValueFromJson(Map<String, dynamic> json) =>
    UnitValue(json['unit'] as String, (json['value'] as num).toDouble());

Map<String, dynamic> _$UnitValueToJson(UnitValue instance) => <String, dynamic>{
  'value': instance.value,
  'unit': instance.unit,
};

LengthUnitValue _$LengthUnitValueFromJson(Map<String, dynamic> json) =>
    LengthUnitValue(json['unit'] as String, (json['value'] as num).toDouble());

Map<String, dynamic> _$LengthUnitValueToJson(LengthUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

DurationUnitValue _$DurationUnitValueFromJson(Map<String, dynamic> json) =>
    DurationUnitValue(
      json['unit'] as String,
      (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$DurationUnitValueToJson(DurationUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

KcalUnitValue _$KcalUnitValueFromJson(Map<String, dynamic> json) =>
    KcalUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$KcalUnitValueToJson(KcalUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

SpeedUnitValue _$SpeedUnitValueFromJson(Map<String, dynamic> json) =>
    SpeedUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$SpeedUnitValueToJson(SpeedUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

PercentUnitValue _$PercentUnitValueFromJson(Map<String, dynamic> json) =>
    PercentUnitValue(
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String? ?? PercentUnit.PERCENT,
    );

Map<String, dynamic> _$PercentUnitValueToJson(PercentUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

SoundUnitValue _$SoundUnitValueFromJson(Map<String, dynamic> json) =>
    SoundUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$SoundUnitValueToJson(SoundUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

IlluminanceUnitValue _$IlluminanceUnitValueFromJson(
  Map<String, dynamic> json,
) => IlluminanceUnitValue(
  value: (json['value'] as num).toDouble(),
  unit: json['unit'] as String? ?? IlluminanceUnit.LUX,
);

Map<String, dynamic> _$IlluminanceUnitValueToJson(
  IlluminanceUnitValue instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};

TemperatureUnitValue _$TemperatureUnitValueFromJson(
  Map<String, dynamic> json,
) => TemperatureUnitValue(
  unit: json['unit'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$TemperatureUnitValueToJson(
  TemperatureUnitValue instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};

UnitValueRange _$UnitValueRangeFromJson(Map<String, dynamic> json) =>
    UnitValueRange(
      lowValue: (json['low_value'] as num).toDouble(),
      highValue: (json['high_value'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$UnitValueRangeToJson(UnitValueRange instance) =>
    <String, dynamic>{
      'low_value': instance.lowValue,
      'high_value': instance.highValue,
      'unit': instance.unit,
    };

DurationUnitValueRange _$DurationUnitValueRangeFromJson(
  Map<String, dynamic> json,
) => DurationUnitValueRange(
  lowValue: (json['low_value'] as num).toDouble(),
  highValue: (json['high_value'] as num).toDouble(),
  unit: json['unit'] as String,
);

Map<String, dynamic> _$DurationUnitValueRangeToJson(
  DurationUnitValueRange instance,
) => <String, dynamic>{
  'low_value': instance.lowValue,
  'high_value': instance.highValue,
  'unit': instance.unit,
};

FrequencyUnitValue _$FrequencyUnitValueFromJson(Map<String, dynamic> json) =>
    FrequencyUnitValue(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      numberOfTimes: (json['number_of_times'] as num?)?.toDouble(),
      timeWindow: FrequencyUnitValue._timeWindowFromJson(json['time_window']),
    );

Map<String, dynamic> _$FrequencyUnitValueToJson(FrequencyUnitValue instance) =>
    <String, dynamic>{
      'value': ?instance.value,
      'unit': ?instance.unit,
      'number_of_times': ?instance.numberOfTimes,
      'time_window': ?instance.timeWindow,
    };

TimeFrame _$TimeFrameFromJson(Map<String, dynamic> json) => TimeFrame(
  timeInterval: json['time_interval'] == null
      ? null
      : TimeInterval.fromJson(json['time_interval'] as Map<String, dynamic>),
  dateTime: _$JsonConverterFromJson<String, DateTime>(
    json['date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
);

Map<String, dynamic> _$TimeFrameToJson(TimeFrame instance) => <String, dynamic>{
  'time_interval': ?instance.timeInterval,
  'date_time': ?_$JsonConverterToJson<String, DateTime>(
    instance.dateTime,
    const _UtcDateTimeConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval(
  startDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['start_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
  endDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['end_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
  duration: json['duration'] == null
      ? null
      : DurationUnitValue.fromJson(json['duration'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'start_date_time': ?_$JsonConverterToJson<String, DateTime>(
        instance.startDateTime,
        const _UtcDateTimeConverter().toJson,
      ),
      'end_date_time': ?_$JsonConverterToJson<String, DateTime>(
        instance.endDateTime,
        const _UtcDateTimeConverter().toJson,
      ),
      'duration': ?instance.duration,
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

ApneaHypopneaIndex _$ApneaHypopneaIndexFromJson(Map<String, dynamic> json) =>
    ApneaHypopneaIndex(
      apneaHypopneaIndex: UnitValue.fromJson(
        json['apnea_hypopnea_index'] as Map<String, dynamic>,
      ),
      effectiveTimeFrame: TimeFrame.fromJson(
        json['effective_time_frame'] as Map<String, dynamic>,
      ),
      descriptiveStatistic: json['descriptive_statistic'] as String?,
      descriptiveStatisticDenominator:
          json['descriptive_statistic_denominator'] as String?,
    )..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$ApneaHypopneaIndexToJson(ApneaHypopneaIndex instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'apnea_hypopnea_index': instance.apneaHypopneaIndex,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

ArousalIndex _$ArousalIndexFromJson(Map<String, dynamic> json) => ArousalIndex(
  arousalIndex: UnitValue.fromJson(
    json['arousal_index'] as Map<String, dynamic>,
  ),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  isMainSleep: json['is_main_sleep'] as bool?,
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$ArousalIndexToJson(ArousalIndex instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'arousal_index': instance.arousalIndex,
      'is_main_sleep': ?instance.isMainSleep,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

DeepSleep _$DeepSleepFromJson(Map<String, dynamic> json) => DeepSleep(
  deepSleepDuration: DurationUnitValue.fromJson(
    json['deep_sleep_duration'] as Map<String, dynamic>,
  ),
  totalSleepTime: DurationUnitValue.fromJson(
    json['total_sleep_time'] as Map<String, dynamic>,
  ),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  deepSleepPercentage: json['deep_sleep_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['deep_sleep_percentage'] as Map<String, dynamic>,
        ),
  isMainSleep: json['is_main_sleep'] as bool?,
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$DeepSleepToJson(DeepSleep instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'deep_sleep_duration': instance.deepSleepDuration,
  'total_sleep_time': instance.totalSleepTime,
  'deep_sleep_percentage': ?instance.deepSleepPercentage,
  'is_main_sleep': ?instance.isMainSleep,
  'descriptive_statistic_denominator':
      ?instance.descriptiveStatisticDenominator,
};

LightSleep _$LightSleepFromJson(Map<String, dynamic> json) => LightSleep(
  lightSleepDuration: DurationUnitValue.fromJson(
    json['light_sleep_duration'] as Map<String, dynamic>,
  ),
  totalSleepTime: DurationUnitValue.fromJson(
    json['total_sleep_time'] as Map<String, dynamic>,
  ),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  lightSleepPercentage: json['light_sleep_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['light_sleep_percentage'] as Map<String, dynamic>,
        ),
  isMainSleep: json['is_main_sleep'] as bool?,
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$LightSleepToJson(LightSleep instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'light_sleep_duration': instance.lightSleepDuration,
      'total_sleep_time': instance.totalSleepTime,
      'light_sleep_percentage': ?instance.lightSleepPercentage,
      'is_main_sleep': ?instance.isMainSleep,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

SleepEpisode _$SleepEpisodeFromJson(Map<String, dynamic> json) =>
    SleepEpisode(
        effectiveTimeFrame: TimeFrame.fromJson(
          json['effective_time_frame'] as Map<String, dynamic>,
        ),
        latencyToSleepOnset: json['latency_to_sleep_onset'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['latency_to_sleep_onset'] as Map<String, dynamic>,
              ),
        latencyToArising: json['latency_to_arising'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['latency_to_arising'] as Map<String, dynamic>,
              ),
        totalSleepTime: json['total_sleep_time'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['total_sleep_time'] as Map<String, dynamic>,
              ),
        lightSleepDuration: json['light_sleep_duration'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['light_sleep_duration'] as Map<String, dynamic>,
              ),
        deepSleepDuration: json['deep_sleep_duration'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['deep_sleep_duration'] as Map<String, dynamic>,
              ),
        remSleepDuration: json['rem_sleep_duration'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['rem_sleep_duration'] as Map<String, dynamic>,
              ),
        wakeAfterSleepOnset: json['wake_after_sleep_onset'] == null
            ? null
            : DurationUnitValue.fromJson(
                json['wake_after_sleep_onset'] as Map<String, dynamic>,
              ),
        numberOfAwakenings: (json['number_of_awakenings'] as num?)?.toInt(),
        isMainSleep: json['is_main_sleep'] as bool?,
        sleepEfficiencyPercentage: json['sleep_efficiency_percentage'] == null
            ? null
            : PercentUnitValue.fromJson(
                json['sleep_efficiency_percentage'] as Map<String, dynamic>,
              ),
      )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$SleepEpisodeToJson(SleepEpisode instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'latency_to_sleep_onset': ?instance.latencyToSleepOnset,
      'latency_to_arising': ?instance.latencyToArising,
      'total_sleep_time': ?instance.totalSleepTime,
      'light_sleep_duration': ?instance.lightSleepDuration,
      'deep_sleep_duration': ?instance.deepSleepDuration,
      'rem_sleep_duration': ?instance.remSleepDuration,
      'wake_after_sleep_onset': ?instance.wakeAfterSleepOnset,
      'number_of_awakenings': ?instance.numberOfAwakenings,
      'is_main_sleep': ?instance.isMainSleep,
      'sleep_efficiency_percentage': ?instance.sleepEfficiencyPercentage,
    };

SleepOnsetLatency _$SleepOnsetLatencyFromJson(Map<String, dynamic> json) =>
    SleepOnsetLatency(
      sleepOnsetLatency: DurationUnitValue.fromJson(
        json['sleep_onset_latency'] as Map<String, dynamic>,
      ),
      effectiveTimeFrame: TimeFrame.fromJson(
        json['effective_time_frame'] as Map<String, dynamic>,
      ),
      isMainSleep: json['is_main_sleep'] as bool?,
      descriptiveStatistic: json['descriptive_statistic'] as String?,
      descriptiveStatisticDenominator:
          json['descriptive_statistic_denominator'] as String?,
    )..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$SleepOnsetLatencyToJson(SleepOnsetLatency instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'sleep_onset_latency': instance.sleepOnsetLatency,
      'is_main_sleep': ?instance.isMainSleep,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

SleepStageSummary _$SleepStageSummaryFromJson(Map<String, dynamic> json) =>
    SleepStageSummary(
        sleepStageSummary: SleepStageSummaryDetails.fromJson(
          json['sleep_stage_summary'] as Map<String, dynamic>,
        ),
        effectiveTimeFrame: TimeFrame.fromJson(
          json['effective_time_frame'] as Map<String, dynamic>,
        ),
        sleepStageEpisodes: (json['sleep_stage_episodes'] as List<dynamic>?)
            ?.map((e) => SleepStageEpisode.fromJson(e as Map<String, dynamic>))
            .toList(),
        isMainSleep: json['is_main_sleep'] as bool?,
      )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$SleepStageSummaryToJson(SleepStageSummary instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'sleep_stage_summary': instance.sleepStageSummary,
      'sleep_stage_episodes': ?instance.sleepStageEpisodes,
      'is_main_sleep': ?instance.isMainSleep,
    };

SleepStageSummaryDetails _$SleepStageSummaryDetailsFromJson(
  Map<String, dynamic> json,
) => SleepStageSummaryDetails(
  totalSleepTime: DurationUnitValue.fromJson(
    json['total_sleep_time'] as Map<String, dynamic>,
  ),
  sleepEfficiencyPercentage: json['sleep_efficiency_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['sleep_efficiency_percentage'] as Map<String, dynamic>,
        ),
  latencyToSleepOnset: json['latency_to_sleep_onset'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['latency_to_sleep_onset'] as Map<String, dynamic>,
        ),
  latencyToArising: json['latency_to_arising'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['latency_to_arising'] as Map<String, dynamic>,
        ),
  remSleepDuration: json['rem_sleep_duration'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['rem_sleep_duration'] as Map<String, dynamic>,
        ),
  remSleepEpisodeCount: (json['rem_sleep_episode_count'] as num?)?.toInt(),
  remSleepPercentage: json['rem_sleep_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['rem_sleep_percentage'] as Map<String, dynamic>,
        ),
  lightSleepDuration: json['light_sleep_duration'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['light_sleep_duration'] as Map<String, dynamic>,
        ),
  lightSleepEpisodeCount: (json['light_sleep_episode_count'] as num?)?.toInt(),
  lightSleepPercentage: json['light_sleep_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['light_sleep_percentage'] as Map<String, dynamic>,
        ),
  deepSleepDuration: json['deep_sleep_duration'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['deep_sleep_duration'] as Map<String, dynamic>,
        ),
  deepSleepEpisodeCount: (json['deep_sleep_episode_count'] as num?)?.toInt(),
  deepSleepPercentage: json['deep_sleep_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['deep_sleep_percentage'] as Map<String, dynamic>,
        ),
  awakeDuration: json['awake_duration'] == null
      ? null
      : DurationUnitValue.fromJson(
          json['awake_duration'] as Map<String, dynamic>,
        ),
  numberOfAwakenings: (json['number_of_awakenings'] as num?)?.toInt(),
  awakePercentage: json['awake_percentage'] == null
      ? null
      : PercentUnitValue.fromJson(
          json['awake_percentage'] as Map<String, dynamic>,
        ),
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
);

Map<String, dynamic> _$SleepStageSummaryDetailsToJson(
  SleepStageSummaryDetails instance,
) => <String, dynamic>{
  'total_sleep_time': instance.totalSleepTime,
  'sleep_efficiency_percentage': ?instance.sleepEfficiencyPercentage,
  'latency_to_sleep_onset': ?instance.latencyToSleepOnset,
  'latency_to_arising': ?instance.latencyToArising,
  'rem_sleep_duration': ?instance.remSleepDuration,
  'rem_sleep_episode_count': ?instance.remSleepEpisodeCount,
  'rem_sleep_percentage': ?instance.remSleepPercentage,
  'light_sleep_duration': ?instance.lightSleepDuration,
  'light_sleep_episode_count': ?instance.lightSleepEpisodeCount,
  'light_sleep_percentage': ?instance.lightSleepPercentage,
  'deep_sleep_duration': ?instance.deepSleepDuration,
  'deep_sleep_episode_count': ?instance.deepSleepEpisodeCount,
  'deep_sleep_percentage': ?instance.deepSleepPercentage,
  'awake_duration': ?instance.awakeDuration,
  'number_of_awakenings': ?instance.numberOfAwakenings,
  'awake_percentage': ?instance.awakePercentage,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'descriptive_statistic_denominator':
      ?instance.descriptiveStatisticDenominator,
};

SleepStageEpisode _$SleepStageEpisodeFromJson(Map<String, dynamic> json) =>
    SleepStageEpisode(
      sleepStageState: json['sleep_stage_state'] as String,
      sleepStageTimeFrame: TimeFrame.fromJson(
        json['sleep_stage_time_frame'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SleepStageEpisodeToJson(SleepStageEpisode instance) =>
    <String, dynamic>{
      'sleep_stage_state': instance.sleepStageState,
      'sleep_stage_time_frame': instance.sleepStageTimeFrame,
    };

SnoreIndex _$SnoreIndexFromJson(Map<String, dynamic> json) => SnoreIndex(
  snoreIndex: UnitValue.fromJson(json['snore_index'] as Map<String, dynamic>),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  snoreEvents: (json['snore_events'] as List<dynamic>?)
      ?.map((e) => SnoreEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
  isMainSleep: json['is_main_sleep'] as bool?,
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$SnoreIndexToJson(SnoreIndex instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'snore_index': instance.snoreIndex,
      'snore_events': ?instance.snoreEvents,
      'is_main_sleep': ?instance.isMainSleep,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

SnoreEvent _$SnoreEventFromJson(Map<String, dynamic> json) => SnoreEvent(
  snored: json['snored'] as bool,
  snoreTimeFrame: TimeInterval.fromJson(
    json['snore_time_frame'] as Map<String, dynamic>,
  ),
  snoreIntensity: json['snore_intensity'] == null
      ? null
      : SoundUnitValue.fromJson(
          json['snore_intensity'] as Map<String, dynamic>,
        ),
  bodyPosture: json['body_posture'] as String?,
);

Map<String, dynamic> _$SnoreEventToJson(SnoreEvent instance) =>
    <String, dynamic>{
      'snored': instance.snored,
      'snore_time_frame': instance.snoreTimeFrame,
      'snore_intensity': ?instance.snoreIntensity,
      'body_posture': ?instance.bodyPosture,
    };

TimeInBed _$TimeInBedFromJson(Map<String, dynamic> json) => TimeInBed(
  timeInBed: DurationUnitValue.fromJson(
    json['time_in_bed'] as Map<String, dynamic>,
  ),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  isMainSleep: json['is_main_sleep'] as bool?,
  descriptiveStatistic: json['descriptive_statistic'] as String?,
  descriptiveStatisticDenominator:
      json['descriptive_statistic_denominator'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$TimeInBedToJson(TimeInBed instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'time_in_bed': instance.timeInBed,
  'is_main_sleep': ?instance.isMainSleep,
  'descriptive_statistic_denominator':
      ?instance.descriptiveStatisticDenominator,
};

TotalSleepTime _$TotalSleepTimeFromJson(Map<String, dynamic> json) =>
    TotalSleepTime(
      totalSleepTime: DurationUnitValue.fromJson(
        json['total_sleep_time'] as Map<String, dynamic>,
      ),
      effectiveTimeFrame: TimeFrame.fromJson(
        json['effective_time_frame'] as Map<String, dynamic>,
      ),
      sleepEvents: (json['sleep_events'] as List<dynamic>?)
          ?.map((e) => TimeInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
      isMainSleep: json['is_main_sleep'] as bool?,
      descriptiveStatistic: json['descriptive_statistic'] as String?,
      descriptiveStatisticDenominator:
          json['descriptive_statistic_denominator'] as String?,
    )..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$TotalSleepTimeToJson(TotalSleepTime instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'total_sleep_time': instance.totalSleepTime,
      'sleep_events': ?instance.sleepEvents,
      'is_main_sleep': ?instance.isMainSleep,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

WakeAfterSleepOnset _$WakeAfterSleepOnsetFromJson(Map<String, dynamic> json) =>
    WakeAfterSleepOnset(
      wakeAfterSleepOnset: DurationUnitValue.fromJson(
        json['wake_after_sleep_onset'] as Map<String, dynamic>,
      ),
      effectiveTimeFrame: TimeFrame.fromJson(
        json['effective_time_frame'] as Map<String, dynamic>,
      ),
      awakeningDurations: (json['awakening_durations'] as List<dynamic>?)
          ?.map((e) => DurationUnitValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      descriptiveStatistic: json['descriptive_statistic'] as String?,
      descriptiveStatisticDenominator:
          json['descriptive_statistic_denominator'] as String?,
    )..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$WakeAfterSleepOnsetToJson(
  WakeAfterSleepOnset instance,
) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'wake_after_sleep_onset': instance.wakeAfterSleepOnset,
  'awakening_durations': ?instance.awakeningDurations,
  'descriptive_statistic_denominator':
      ?instance.descriptiveStatisticDenominator,
};

AmbientLight _$AmbientLightFromJson(Map<String, dynamic> json) => AmbientLight(
  ambientLight: (json['ambient_light'] as List<dynamic>)
      .map((e) => AmbientLightComponent.fromJson(e as Map<String, dynamic>))
      .toList(),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  descriptiveStatistic: json['descriptive_statistic'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$AmbientLightToJson(AmbientLight instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'ambient_light': instance.ambientLight,
    };

AmbientLightComponent _$AmbientLightComponentFromJson(
  Map<String, dynamic> json,
) => AmbientLightComponent(
  intensity: IlluminanceUnitValue.fromJson(
    json['intensity'] as Map<String, dynamic>,
  ),
  wavelength: json['wavelength'] == null
      ? null
      : LengthUnitValue.fromJson(json['wavelength'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AmbientLightComponentToJson(
  AmbientLightComponent instance,
) => <String, dynamic>{
  'wavelength': ?instance.wavelength,
  'intensity': instance.intensity,
};

AmbientSound _$AmbientSoundFromJson(Map<String, dynamic> json) => AmbientSound(
  ambientSound: SoundUnitValue.fromJson(
    json['ambient_sound'] as Map<String, dynamic>,
  ),
  effectiveTimeFrame: TimeFrame.fromJson(
    json['effective_time_frame'] as Map<String, dynamic>,
  ),
  descriptiveStatistic: json['descriptive_statistic'] as String?,
)..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$AmbientSoundToJson(AmbientSound instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'ambient_sound': instance.ambientSound,
    };

AmbientTemperature _$AmbientTemperatureFromJson(Map<String, dynamic> json) =>
    AmbientTemperature(
      ambientTemperature: TemperatureUnitValue.fromJson(
        json['ambient_temperature'] as Map<String, dynamic>,
      ),
      effectiveTimeFrame: TimeFrame.fromJson(
        json['effective_time_frame'] as Map<String, dynamic>,
      ),
      descriptiveStatistic: json['descriptive_statistic'] as String?,
    )..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$AmbientTemperatureToJson(AmbientTemperature instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'ambient_temperature': instance.ambientTemperature,
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
  startDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['start_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
  endDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['end_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
  endStatus: json['end_status'] as String?,
);

Map<String, dynamic> _$SurveyDeliveryDetailsToJson(
  SurveyDeliveryDetails instance,
) => <String, dynamic>{
  'start_date_time': ?_$JsonConverterToJson<String, DateTime>(
    instance.startDateTime,
    const _UtcDateTimeConverter().toJson,
  ),
  'end_date_time': ?_$JsonConverterToJson<String, DateTime>(
    instance.endDateTime,
    const _UtcDateTimeConverter().toJson,
  ),
  'end_status': ?instance.endStatus,
};

SurveyItem _$SurveyItemFromJson(Map<String, dynamic> json) => SurveyItem(
  question: SurveyQuestion.fromJson(json['question'] as Map<String, dynamic>),
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => SurveyAnswer.fromJson(e as Map<String, dynamic>))
      .toList(),
  askedDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['asked_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
  answeredDateTime: _$JsonConverterFromJson<String, DateTime>(
    json['answered_date_time'],
    const _UtcDateTimeConverter().fromJson,
  ),
);

Map<String, dynamic> _$SurveyItemToJson(SurveyItem instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answers': instance.answers,
      'asked_date_time': ?_$JsonConverterToJson<String, DateTime>(
        instance.askedDateTime,
        const _UtcDateTimeConverter().toJson,
      ),
      'answered_date_time': ?_$JsonConverterToJson<String, DateTime>(
        instance.answeredDateTime,
        const _UtcDateTimeConverter().toJson,
      ),
    };

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    SurveyQuestion(
      text: json['text'] as String,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{'text': instance.text, 'label': ?instance.label};

SurveyAnswer _$SurveyAnswerFromJson(Map<String, dynamic> json) =>
    SurveyAnswer(value: json['value'] as Object, code: json['code']);

Map<String, dynamic> _$SurveyAnswerToJson(SurveyAnswer instance) =>
    <String, dynamic>{'value': instance.value, 'code': ?instance.code};

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

Acceleration _$AccelerationFromJson(Map<String, dynamic> json) =>
    Acceleration(
        accelerationX: AccelerationUnitValue.fromJson(
          json['acceleration_x'] as Map<String, dynamic>,
        ),
        accelerationY: AccelerationUnitValue.fromJson(
          json['acceleration_y'] as Map<String, dynamic>,
        ),
        accelerationZ: json['acceleration_z'] == null
            ? null
            : AccelerationUnitValue.fromJson(
                json['acceleration_z'] as Map<String, dynamic>,
              ),
        sensorBodyLocation: json['sensor_body_location'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$AccelerationToJson(Acceleration instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'acceleration_x': instance.accelerationX,
      'acceleration_y': instance.accelerationY,
      'acceleration_z': ?instance.accelerationZ,
      'sensor_body_location': ?instance.sensorBodyLocation,
    };

AccelerationUnitValue _$AccelerationUnitValueFromJson(
  Map<String, dynamic> json,
) => AccelerationUnitValue(
  unit: json['unit'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$AccelerationUnitValueToJson(
  AccelerationUnitValue instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};

CaloriesBurned _$CaloriesBurnedFromJson(Map<String, dynamic> json) =>
    CaloriesBurned(
        kcalBurned: KcalUnitValue.fromJson(
          json['kcal_burned'] as Map<String, dynamic>,
        ),
        activityName: json['activity_name'] as String?,
        descriptiveStatisticDenominator:
            json['descriptive_statistic_denominator'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$CaloriesBurnedToJson(CaloriesBurned instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'kcal_burned': instance.kcalBurned,
      'activity_name': ?instance.activityName,
      'descriptive_statistic_denominator':
          ?instance.descriptiveStatisticDenominator,
    };

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) =>
    BloodPressure(
        systolicBloodPressure: SystolicBloodPressure.fromJson(
          json['systolic_blood_pressure'] as Map<String, dynamic>,
        ),
        diastolicBloodPressure: DiastolicBloodPressure.fromJson(
          json['diastolic_blood_pressure'] as Map<String, dynamic>,
        ),
        bodyPosture: json['body_posture'] as String?,
        measurementLocation: json['measurement_location'] as String?,
        temporalRelationshipToPhysicalActivity:
            json['temporal_relationship_to_physical_activity'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$BloodPressureToJson(BloodPressure instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'systolic_blood_pressure': instance.systolicBloodPressure,
      'diastolic_blood_pressure': instance.diastolicBloodPressure,
      'body_posture': ?instance.bodyPosture,
      'measurement_location': ?instance.measurementLocation,
      'temporal_relationship_to_physical_activity':
          ?instance.temporalRelationshipToPhysicalActivity,
    };

SystolicBloodPressure _$SystolicBloodPressureFromJson(
  Map<String, dynamic> json,
) => SystolicBloodPressure(
  unit: json['unit'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$SystolicBloodPressureToJson(
  SystolicBloodPressure instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};

DiastolicBloodPressure _$DiastolicBloodPressureFromJson(
  Map<String, dynamic> json,
) => DiastolicBloodPressure(
  unit: json['unit'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$DiastolicBloodPressureToJson(
  DiastolicBloodPressure instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};

HeartRate _$HeartRateFromJson(Map<String, dynamic> json) =>
    HeartRate(
        heartRate: HeartRateUnitValue.fromJson(
          json['heart_rate'] as Map<String, dynamic>,
        ),
        temporalRelationshipToPhysicalActivity:
            json['temporal_relationship_to_physical_activity'] as String?,
        temporalRelationshipToSleep:
            json['temporal_relationship_to_sleep'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$HeartRateToJson(HeartRate instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'heart_rate': instance.heartRate,
  'temporal_relationship_to_physical_activity':
      ?instance.temporalRelationshipToPhysicalActivity,
  'temporal_relationship_to_sleep': ?instance.temporalRelationshipToSleep,
};

RrInterval _$RrIntervalFromJson(Map<String, dynamic> json) =>
    RrInterval(
        rrInterval: RrInterUnitValue.fromJson(
          json['rr_interval'] as Map<String, dynamic>,
        ),
        temporalRelationshipToPhysicalActivity:
            json['temporal_relationship_to_physical_activity'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$RrIntervalToJson(RrInterval instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'rr_interval': instance.rrInterval,
      'temporal_relationship_to_physical_activity':
          ?instance.temporalRelationshipToPhysicalActivity,
    };

HeartRateUnitValue _$HeartRateUnitValueFromJson(Map<String, dynamic> json) =>
    HeartRateUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$HeartRateUnitValueToJson(HeartRateUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

RrInterUnitValue _$RrInterUnitValueFromJson(Map<String, dynamic> json) =>
    RrInterUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$RrInterUnitValueToJson(RrInterUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

Geoposition _$GeopositionFromJson(Map<String, dynamic> json) =>
    Geoposition(
        latitude: PlaneAngleUnitValue.fromJson(
          json['latitude'] as Map<String, dynamic>,
        ),
        longitude: PlaneAngleUnitValue.fromJson(
          json['longitude'] as Map<String, dynamic>,
        ),
        elevation: json['elevation'] == null
            ? null
            : LengthUnitValue.fromJson(
                json['elevation'] as Map<String, dynamic>,
              ),
        numberOfSatellitesInView: (json['number_of_satellites_in_view'] as num?)
            ?.toInt(),
        numberOfSatellitesInFix: (json['number_of_satellites_in_fix'] as num?)
            ?.toInt(),
        satelliteSignalStrengths:
            (json['satellite_signal_strengths'] as List<dynamic>?)
                ?.map((e) => UnitValue.fromJson(e as Map<String, dynamic>))
                .toList(),
        positioningSystem: json['positioning_system'] as String?,
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$GeopositionToJson(Geoposition instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'elevation': ?instance.elevation,
      'number_of_satellites_in_view': ?instance.numberOfSatellitesInView,
      'number_of_satellites_in_fix': ?instance.numberOfSatellitesInFix,
      'satellite_signal_strengths': ?instance.satelliteSignalStrengths,
      'positioning_system': ?instance.positioningSystem,
    };

PlaneAngleUnitValue _$PlaneAngleUnitValueFromJson(Map<String, dynamic> json) =>
    PlaneAngleUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaneAngleUnitValueToJson(
  PlaneAngleUnitValue instance,
) => <String, dynamic>{'value': instance.value, 'unit': instance.unit};
