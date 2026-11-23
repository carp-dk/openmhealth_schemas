/// Tests that the JSON generated from measures created in Dart complies with
/// the IEEE 1752.1 and OMH schemas, loaded directly from the upstream
/// repositories.
///
/// For each measure of this package, an example is created using the Dart
/// constructors, put in a [DataPoint], and the JSON of the data point and its
/// body is validated against the schemas.
///
/// These tests need network access. Skip them with `dart test -x remote`.
@Tags(['remote'])
library;

import 'dart:convert';

import 'package:openmhealth_schemas/openmhealth_schemas.dart';
import 'package:test/test.dart';

import 'support/remote.dart';
import 'support/validation.dart';

final DateTime _start = DateTime.utc(2026, 11, 22, 23);
final DateTime _end = DateTime.utc(2026, 11, 23, 7);
final TimeFrame _pointInTime = TimeFrame(dateTime: _end);
final TimeFrame _interval = TimeFrame(
  timeInterval: TimeInterval(startDateTime: _start, endDateTime: _end),
);

DurationUnitValue _hours(double hours) =>
    DurationUnitValue(DurationUnit.HOUR, hours);
DurationUnitValue _minutes(double minutes) =>
    DurationUnitValue(DurationUnit.MINUTE, minutes);

/// An example of each measure of this package, using as many properties as
/// possible.
final Map<String, Measure Function()> examples = {
  // IEEE 1752.1
  'physical activity': () => PhysicalActivity(
    activityName: 'walking',
    effectiveTimeFrame: _interval,
    baseMovementQuantity: UnitValue(BaseMovementUnit.STEPS, 5400),
    distance: LengthUnitValue(LengthUnit.KILOMETER, 4.2),
    cumulativeElevationGain: LengthUnitValue(LengthUnit.METER, 35),
    duration: _minutes(52),
    durationLightActivity: _minutes(10),
    durationModerateActivity: _minutes(42),
    durationVigorousActivity: _minutes(0),
    averageCadence: UnitValue(CadenceUnit.STEPS_PER_MINUTE, 104),
    averageSpeed: SpeedUnitValue(
      unit: SpeedUnit.KILOMETERS_PER_HOUR,
      value: 4.8,
    ),
    kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 210),
    reportedActivityIntensity: SelfReportedIntensity.MODERATE,
    metValue: 3.5,
    descriptiveStatistic: DescriptiveStatistic.SUM,
    descriptiveStatisticDenominator: DescriptiveStatisticDenominator.DAY,
  ),
  'survey': () => Survey(
    items: [
      SurveyItem(
        question: SurveyQuestion(text: 'How often do you snore?', label: 'Q1'),
        answers: [SurveyCategoricalAnswer(value: 'Never', code: 1)],
        askedDateTime: _start,
        answeredDateTime: _end,
      ),
      SurveyItem(
        question: SurveyQuestion(text: 'When did you start snoring?'),
        answers: [SurveyDateAnswer.fromDateTime(DateTime.utc(2020, 3, 1))],
      ),
      SurveyItem(
        question: SurveyQuestion(text: 'When do you usually go to bed?'),
        answers: [SurveyTimeAnswer(value: '23:15')],
      ),
      SurveyItem(
        question: SurveyQuestion(text: 'How long do you usually sleep?'),
        answers: [SurveyUnitValueAnswer(value: _hours(7.5))],
      ),
      SurveyItem(
        question: SurveyQuestion(text: 'Do you feel rested?'),
        answers: [SurveyAnswer(value: true)],
      ),
      SurveyItem(question: SurveyQuestion(text: 'Not answered')),
    ],
    deliveryDetails: SurveyDeliveryDetails(
      startDateTime: _start,
      endDateTime: _end,
      endStatus: SurveyEndStatus.COMPLETED,
    ),
    score: 7,
  ),
  'apnea hypopnea index': () => ApneaHypopneaIndex(
    apneaHypopneaIndex: UnitValue(SleepIndexUnit.EVENTS_PER_HOUR, 4.2),
    effectiveTimeFrame: _interval,
    descriptiveStatistic: DescriptiveStatistic.AVERAGE,
    descriptiveStatisticDenominator: DescriptiveStatisticDenominator.EPISODE,
  ),
  'arousal index': () => ArousalIndex(
    arousalIndex: UnitValue(SleepIndexUnit.AWAKENINGS_PER_HOUR, 12),
    effectiveTimeFrame: _interval,
    isMainSleep: true,
  ),
  'deep sleep': () => DeepSleep(
    deepSleepDuration: _minutes(85),
    totalSleepTime: _hours(7.2),
    effectiveTimeFrame: _interval,
    deepSleepPercentage: PercentUnitValue(value: 19.7),
    isMainSleep: true,
  ),
  'light sleep': () => LightSleep(
    lightSleepDuration: _hours(3.9),
    totalSleepTime: _hours(7.2),
    effectiveTimeFrame: _interval,
    lightSleepPercentage: PercentUnitValue(value: 54.2),
    isMainSleep: true,
  ),
  'sleep episode': () => SleepEpisode(
    effectiveTimeFrame: _interval,
    latencyToSleepOnset: _minutes(15),
    latencyToArising: _minutes(5),
    totalSleepTime: _hours(7.2),
    lightSleepDuration: _hours(3.9),
    deepSleepDuration: _minutes(85),
    remSleepDuration: _minutes(95),
    wakeAfterSleepOnset: _minutes(20),
    numberOfAwakenings: 3,
    isMainSleep: true,
    sleepEfficiencyPercentage: PercentUnitValue(value: 90),
  ),
  'sleep onset latency': () => SleepOnsetLatency(
    sleepOnsetLatency: _minutes(15),
    effectiveTimeFrame: _interval,
    isMainSleep: true,
  ),
  'sleep stage summary': () => SleepStageSummary(
    sleepStageSummary: SleepStageSummaryDetails(
      totalSleepTime: _hours(7.2),
      sleepEfficiencyPercentage: PercentUnitValue(value: 90),
      remSleepDuration: _minutes(95),
      remSleepEpisodeCount: 4,
      deepSleepDuration: _minutes(85),
      awakeDuration: _minutes(20),
      numberOfAwakenings: 3,
    ),
    effectiveTimeFrame: _interval,
    sleepStageEpisodes: [
      SleepStageEpisode(
        sleepStageState: SleepStageState.LIGHT,
        sleepStageTimeFrame: _interval,
      ),
    ],
    isMainSleep: true,
  ),
  'snore index': () => SnoreIndex(
    snoreIndex: UnitValue(SleepIndexUnit.SNORES_PER_HOUR, 7),
    effectiveTimeFrame: _interval,
    snoreEvents: [
      SnoreEvent(
        snored: true,
        snoreTimeFrame: TimeInterval(startDateTime: _start, duration: _minutes(2)),
        snoreIntensity: SoundUnitValue(unit: SoundUnit.DECIBEL, value: 45),
        bodyPosture: BodyPosture.LYING_DOWN,
      ),
    ],
  ),
  'time in bed': () =>
      TimeInBed(timeInBed: _hours(8), effectiveTimeFrame: _interval),
  'total sleep time': () => TotalSleepTime(
    totalSleepTime: _hours(7.2),
    effectiveTimeFrame: _interval,
    sleepEvents: [TimeInterval(startDateTime: _start, endDateTime: _end)],
  ),
  'wake after sleep onset': () => WakeAfterSleepOnset(
    wakeAfterSleepOnset: _minutes(20),
    effectiveTimeFrame: _interval,
    awakeningDurations: [_minutes(5), _minutes(15)],
  ),
  'ambient light': () => AmbientLight(
    ambientLight: [
      AmbientLightComponent(
        intensity: IlluminanceUnitValue(value: 10.2),
        wavelength: LengthUnitValue(LengthUnit.NANOMETER, 450),
      ),
    ],
    effectiveTimeFrame: _pointInTime,
  ),
  'ambient sound': () => AmbientSound(
    ambientSound: SoundUnitValue(unit: SoundUnit.A_WEIGHTED_DECIBEL, value: 42),
    effectiveTimeFrame: _interval,
    descriptiveStatistic: DescriptiveStatistic.MAXIMUM,
  ),
  'ambient temperature': () => AmbientTemperature(
    ambientTemperature: TemperatureUnitValue(
      unit: TemperatureUnit.CELSIUS,
      value: 19.5,
    ),
    effectiveTimeFrame: _pointInTime,
  ),

  // OMH
  'acceleration': () => Acceleration(
    acceleration_x: AccelerationUnitValue(unit: AccelerationUnit.M_S2, value: 9.8),
    acceleration_y: AccelerationUnitValue(unit: AccelerationUnit.M_S2, value: 0.1),
    acceleration_z: AccelerationUnitValue(unit: AccelerationUnit.M_S2, value: 0.2),
    sensor_body_location: BodyLocation.RIGHT_HIP,
  )..effectiveTimeFrame = _pointInTime,
  'blood pressure': () => BloodPressure(
    systolicBloodPressure: SystolicBloodPressure(
      unit: BloodPressureUnit.MM_OF_MERCURY,
      value: 120,
    ),
    diastolicBloodPressure: DiastolicBloodPressure(
      unit: BloodPressureUnit.MM_OF_MERCURY,
      value: 80,
    ),
    bodyPosture: BodyPosture.SITTING,
    measurementLocation: BodyLocation.LEFT_UPPER_ARM,
    temporalRelationshipToPhysicalActivity:
        TemporalRelationshipToPhysicalActivity.AT_REST,
  )..effectiveTimeFrame = _pointInTime,
  'calories burned': () => CaloriesBurned(
    kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 210),
    activityName: 'walking',
    descriptiveStatisticDenominator: DescriptiveStatisticDenominator.DAY,
  )..effectiveTimeFrame = _interval,
  'geoposition': () =>
      Geoposition(
          latitude: PlaneAngleUnitValue(
            unit: PlaneAngleUnit.DEGREE_OF_ARC,
            value: 55.7858,
          ),
          longitude: PlaneAngleUnitValue(
            unit: PlaneAngleUnit.DEGREE_OF_ARC,
            value: 12.5212,
          ),
          elevation: LengthUnitValue(LengthUnit.METER, 25),
          numberOfSatellitesInView: 9,
          numberOfSatellitesInFix: 7,
          satelliteSignalStrengths: [
            UnitValue(SignalToNoiseRatioUnit.DECIBEL, 35),
          ],
          positioningSystem: PositioningSystem.GPS,
        )
        ..effectiveTimeFrame = _pointInTime,
  'heart rate': () => HeartRate(
    heartRate: HeartRateUnitValue(
      unit: HeartRateUnit.BEATS_PER_MINUTE,
      value: 62,
    ),
    temporalRelationshipToPhysicalActivity:
        TemporalRelationshipToPhysicalActivity.AT_REST,
    temporalRelationshipToSleep: TemporalRelationshipToSleep.ON_WAKING,
  )..effectiveTimeFrame = _pointInTime,
  'rr interval': () => RrInterval(
    rrInterval: RrInterUnitValue(unit: DurationUnit.MILLISECOND, value: 850),
    temporalRelationshipToPhysicalActivity:
        TemporalRelationshipToPhysicalActivity.AT_REST,
  )..effectiveTimeFrame = _pointInTime,
};

/// A data point with all header properties.
DataPoint _dataPoint(Measure body) => DataPoint(
  body: body,
  sourceCreationDateTime: _end,
  modality: DataPointModality.SENSED,
  acquisitionRate: FrequencyUnitValue.times(
    numberOfTimes: 1,
    timeWindow: DurationUnitValue(DurationUnit.DAY, 1),
  ),
  externalDatasheets: [
    ExternalDatasheet(
      datasheetType: 'hardware',
      datasheetReference: 'https://example.com/datasheets/sensor',
    ),
  ],
);

Future<void> main() async {
  final SchemaValidator validator;
  try {
    validator = SchemaValidator(await Ieee.list('schemas'));
  } on UpstreamException catch (error) {
    test('IEEE repository', () => fail('$error'));
    return;
  }

  Future<List<SchemaError>> validate(Object object) => validator
      .validateDataPoint(json.decode(json.encode(object)) as Map<String, dynamic>);

  group('JSON generated in Dart complies with the schema', () {
    for (final MapEntry(key: name, value: example) in examples.entries) {
      test(name, () async {
        final dataPoint = _dataPoint(example());
        expect(
          await validate(dataPoint),
          isEmpty,
          reason: 'The JSON of ${dataPoint.header.schemaId} is not valid',
        );
      });
    }

    test('data series', () async {
      final series = DataSeries(
        body: [examples['heart rate']!(), examples['heart rate']!()],
        modality: DataPointModality.SENSED,
        acquisitionRate: FrequencyUnitValue.hertz(1),
      );
      expect(await validate(series), isEmpty);
    });

    test('all measures have an example', () {
      // Each measure registered in the MeasureFactory needs an example.
      final names = {
        for (final example in examples.values)
          example().getSchemaId().name,
      };
      expect(names, hasLength(22));
    });
  });

  group('JSON not complying with the schema is rejected', () {
    test('heart rate without the required time frame', () async {
      final heartRate = HeartRate(
        heartRate: HeartRateUnitValue(
          unit: HeartRateUnit.BEATS_PER_MINUTE,
          value: 62,
        ),
      );
      expect(await validate(_dataPoint(heartRate)), isNotEmpty);
    });

    test('heart rate with a wrong unit', () async {
      final heartRate = HeartRate(
        heartRate: HeartRateUnitValue(unit: 'bpm', value: 62),
      )..effectiveTimeFrame = _pointInTime;
      expect(await validate(_dataPoint(heartRate)), isNotEmpty);
    });
  });
}
