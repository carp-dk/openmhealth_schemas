// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openmhealth_schemas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Acceleration _$AccelerationFromJson(Map<String, dynamic> json) =>
    Acceleration(
        acceleration_x: AccelerationUnitValue.fromJson(
          json['acceleration_x'] as Map<String, dynamic>,
        ),
        acceleration_y: AccelerationUnitValue.fromJson(
          json['acceleration_y'] as Map<String, dynamic>,
        ),
        acceleration_z: json['acceleration_z'] == null
            ? null
            : AccelerationUnitValue.fromJson(
                json['acceleration_z'] as Map<String, dynamic>,
              ),
        sensor_body_location: json['sensor_body_location'] as String?,
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
      'acceleration_x': instance.acceleration_x,
      'acceleration_y': instance.acceleration_y,
      'acceleration_z': ?instance.acceleration_z,
      'sensor_body_location': ?instance.sensor_body_location,
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

PhysicalActivity _$PhysicalActivityFromJson(Map<String, dynamic> json) =>
    PhysicalActivity(
        activityName: json['activity_name'] as String,
        distance: json['distance'] == null
            ? null
            : LengthUnitValue.fromJson(
                json['distance'] as Map<String, dynamic>,
              ),
        reportedActivityIntensity:
            json['reported_activity_intensity'] as String?,
        caloriesBurned:
            PhysicalActivity._readKcalBurned(json, 'kcal_burned') == null
            ? null
            : KcalUnitValue.fromJson(
                PhysicalActivity._readKcalBurned(json, 'kcal_burned')
                    as Map<String, dynamic>,
              ),
        metValue: (json['met_value'] as num?)?.toDouble(),
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$PhysicalActivityToJson(PhysicalActivity instance) =>
    <String, dynamic>{
      'effective_time_frame': ?instance.effectiveTimeFrame,
      'descriptive_statistic': ?instance.descriptiveStatistic,
      'user_notes': ?instance.userNotes,
      'activity_name': instance.activityName,
      'met_value': ?instance.metValue,
      'distance': ?instance.distance,
      'reported_activity_intensity': ?instance.reportedActivityIntensity,
      'kcal_burned': ?instance.caloriesBurned,
    };

KcalUnitValue _$KcalUnitValueFromJson(Map<String, dynamic> json) =>
    KcalUnitValue(
      unit: json['unit'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$KcalUnitValueToJson(KcalUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

StepCount _$StepCountFromJson(Map<String, dynamic> json) =>
    StepCount(
        stepCount: StepCount._stepCountFromJson(json['step_count']),
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

Map<String, dynamic> _$StepCountToJson(StepCount instance) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'step_count': StepCount._stepCountToJson(instance.stepCount),
  'descriptive_statistic_denominator':
      ?instance.descriptiveStatisticDenominator,
};

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

MinutesModerateActivity _$MinutesModerateActivityFromJson(
  Map<String, dynamic> json,
) =>
    MinutesModerateActivity(
        minutesModerateActivity: DurationUnitValue.fromJson(
          json['minutes_moderate_activity'] as Map<String, dynamic>,
        ),
      )
      ..effectiveTimeFrame = json['effective_time_frame'] == null
          ? null
          : TimeFrame.fromJson(
              json['effective_time_frame'] as Map<String, dynamic>,
            )
      ..descriptiveStatistic = json['descriptive_statistic'] as String?
      ..userNotes = json['user_notes'] as String?;

Map<String, dynamic> _$MinutesModerateActivityToJson(
  MinutesModerateActivity instance,
) => <String, dynamic>{
  'effective_time_frame': ?instance.effectiveTimeFrame,
  'descriptive_statistic': ?instance.descriptiveStatistic,
  'user_notes': ?instance.userNotes,
  'minutes_moderate_activity': instance.minutesModerateActivity,
};

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) =>
    BloodPressure(
        systolicBloodPressure: SystolicBloodPressure.fromJson(
          json['systolic_blood_pressure'] as Map<String, dynamic>,
        ),
        diastolicBloodPressure: DiastolicBloodPressure.fromJson(
          json['diastolic_blood_pressure'] as Map<String, dynamic>,
        ),
        positionDuringMeasurement:
            BloodPressure._readBodyPosture(json, 'body_posture') as String?,
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
      'body_posture': ?instance.positionDuringMeasurement,
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

DataPoint _$DataPointFromJson(Map<String, dynamic> json) => DataPoint(
  body: Measure.fromJson(json['body'] as Map<String, dynamic>),
)..header = DataPointHeader.fromJson(json['header'] as Map<String, dynamic>);

Map<String, dynamic> _$DataPointToJson(DataPoint instance) => <String, dynamic>{
  'header': instance.header,
  'body': instance.body,
};

DataPointHeader _$DataPointHeaderFromJson(Map<String, dynamic> json) =>
    DataPointHeader(
      id: json['id'] as String,
      creationDateTime: DateTime.parse(json['creation_date_time'] as String),
      schemaId: SchemaId.fromJson(json['schema_id'] as Map<String, dynamic>),
      userId: json['user_id'] as String?,
      acquisitionProvenance: json['acquisition_provenance'] == null
          ? null
          : DataPointAcquisitionProvenance.fromJson(
              json['acquisition_provenance'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DataPointHeaderToJson(DataPointHeader instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creation_date_time': instance.creationDateTime.toIso8601String(),
      'schema_id': instance.schemaId,
      'acquisition_provenance': ?instance.acquisitionProvenance,
      'user_id': ?instance.userId,
    };

DataPointAcquisitionProvenance _$DataPointAcquisitionProvenanceFromJson(
  Map<String, dynamic> json,
) => DataPointAcquisitionProvenance(
  sourceName: json['source_name'] as String,
  modality: json['modality'] as String?,
  sourceCreationDateTime: json['source_creation_date_time'] == null
      ? null
      : DateTime.parse(json['source_creation_date_time'] as String),
  sourceDataPointId: json['source_data_point_id'] as String?,
  sourceLastModificationDateTime:
      json['source_last_modification_date_time'] == null
      ? null
      : DateTime.parse(json['source_last_modification_date_time'] as String),
);

Map<String, dynamic> _$DataPointAcquisitionProvenanceToJson(
  DataPointAcquisitionProvenance instance,
) => <String, dynamic>{
  'source_name': instance.sourceName,
  'source_data_point_id': ?instance.sourceDataPointId,
  'source_creation_date_time': ?instance.sourceCreationDateTime
      ?.toIso8601String(),
  'source_last_modification_date_time': ?instance.sourceLastModificationDateTime
      ?.toIso8601String(),
  'modality': ?instance.modality,
};

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

SchemaId _$SchemaIdFromJson(Map<String, dynamic> json) => SchemaId(
  namespace: json['namespace'] as String,
  name: json['name'] as String,
  version: json['version'] as String,
  url: json['url'] as String?,
);

Map<String, dynamic> _$SchemaIdToJson(SchemaId instance) => <String, dynamic>{
  'namespace': instance.namespace,
  'name': instance.name,
  'version': instance.version,
  'url': ?instance.url,
};

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

TimeFrame _$TimeFrameFromJson(Map<String, dynamic> json) => TimeFrame(
  timeInterval: json['time_interval'] == null
      ? null
      : TimeInterval.fromJson(json['time_interval'] as Map<String, dynamic>),
  dateTime: json['date_time'] == null
      ? null
      : DateTime.parse(json['date_time'] as String),
);

Map<String, dynamic> _$TimeFrameToJson(TimeFrame instance) => <String, dynamic>{
  'time_interval': ?instance.timeInterval,
  'date_time': ?instance.dateTime?.toIso8601String(),
};

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval(
  startDateTime: json['start_date_time'] == null
      ? null
      : DateTime.parse(json['start_date_time'] as String),
  endDateTime: json['end_date_time'] == null
      ? null
      : DateTime.parse(json['end_date_time'] as String),
  duration: json['duration'] == null
      ? null
      : DurationUnitValue.fromJson(json['duration'] as Map<String, dynamic>),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  partOfDay: json['part_of_day'] as String?,
);

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'start_date_time': ?instance.startDateTime?.toIso8601String(),
      'end_date_time': ?instance.endDateTime?.toIso8601String(),
      'duration': ?instance.duration,
      'date': ?instance.date?.toIso8601String(),
      'part_of_day': ?instance.partOfDay,
    };

DurationUnitValue _$DurationUnitValueFromJson(Map<String, dynamic> json) =>
    DurationUnitValue(
      json['unit'] as String,
      (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$DurationUnitValueToJson(DurationUnitValue instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

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
