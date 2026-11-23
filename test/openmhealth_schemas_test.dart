/// Tests of the Dart API of this package, which do not need network access.
///
/// The JSON formats of all schemas are tested with the upstream IEEE and OMH
/// test data in `ieee_sample_data_test.dart` and `omh_test_data_test.dart`.
/// The tests here cover what cannot be tested with this data, such as
/// creating data points, the [MeasureFactory], and the checks done when
/// creating objects.
library;

import 'dart:convert';

import 'package:openmhealth_schemas/openmhealth_schemas.dart';
import 'package:test/test.dart';

void main() {
  group('DataPoint', () {
    test('creates a header for the body', () {
      final before = DateTime.now().toUtc();
      final dataPoint = DataPoint(
        body: _bloodPressure(),
        modality: DataPointModality.SENSED,
      );
      final header = dataPoint.header;

      expect(
        header.uuid,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
        reason: 'The uuid must be a random (version 4) UUID',
      );
      expect(header.schemaId.toString(), 'omh.blood-pressure.v4.0');
      expect(header.sourceCreationDateTime.isUtc, isTrue);
      expect(header.sourceCreationDateTime.isBefore(before), isFalse);
      expect(header.modality, DataPointModality.SENSED);
    });

    test('creates a new uuid for each data point', () {
      final body = _bloodPressure();
      expect(
        DataPoint(body: body).header.uuid,
        isNot(DataPoint(body: body).header.uuid),
      );
    });

    test('reads back an OMH body as its Dart class', () {
      final dataPoint = DataPoint(
        body: _bloodPressure(),
        acquisitionRate: FrequencyUnitValue.hertz(1),
        externalDatasheets: [
          ExternalDatasheet(
            datasheetType: 'hardware',
            datasheetReference: 'https://example.com/blood-pressure-monitor',
          ),
        ],
      );

      final readBack = _roundTrip(dataPoint, DataPoint.fromJson);

      expect(readBack.body, isA<BloodPressure>());
      expect((readBack.body as BloodPressure).systolicBloodPressure.value, 160);
      expect(jsonEncode(readBack), jsonEncode(dataPoint));
    });
  });

  group('DataSeries', () {
    test('uses the schema id of the first measure', () {
      final series = DataSeries(
        body: [_totalSleepTime(7.2), _totalSleepTime(6.9)],
      );
      expect(series.header.schemaId.toString(), 'ieee.total-sleep-time.v1.0');
    });

    test('reads back all measures as their Dart class', () {
      final series = DataSeries(
        body: [_totalSleepTime(7.2), _totalSleepTime(6.9)],
      );

      final readBack = _roundTrip(series, DataSeries.fromJson);

      expect(readBack.body, everyElement(isA<TotalSleepTime>()));
      expect(jsonEncode(readBack), jsonEncode(series));
    });

    test('can be empty if a schema id is given', () {
      final series = DataSeries(body: [], schemaId: TotalSleepTime.SCHEMA_ID);
      expect(series.header.schemaId.name, 'total-sleep-time');
    });

    test('rejects an empty series without a schema id', () {
      expect(() => DataSeries(body: []), throwsA(isA<AssertionError>()));
    });

    test('rejects measures of different schemas', () {
      expect(
        () => DataSeries(body: [_totalSleepTime(7.2), _bloodPressure()]),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('MeasureFactory', () {
    test('has all measures of this package registered', () {
      for (final schemaId in [
        PhysicalActivity.SCHEMA_ID,
        Survey.SCHEMA_ID,
        TotalSleepTime.SCHEMA_ID,
        AmbientTemperature.SCHEMA_ID,
        HeartRate.SCHEMA_ID,
        BloodPressure.SCHEMA_ID,
      ]) {
        expect(MeasureFactory.isRegistered(schemaId), isTrue);
      }
    });

    test('reads a measure regardless of the schema version', () {
      final olderVersion = SchemaId(
        namespace: SchemaSupport.OMH_NAMESPACE,
        name: SchemaSupport.HEART_RATE,
        version: '2.0',
      );
      final measure = MeasureFactory.fromJson(olderVersion, {
        'heart_rate': {'value': 62, 'unit': 'beats/min'},
      });
      expect(measure, isA<HeartRate>());
    });

    test('keeps the JSON of an unknown schema in a GenericMeasure', () {
      final json = {
        'header': {
          'uuid': '3f5b4c1e-8d2a-4b7e-9c6f-1a2b3c4d5e6f',
          'source_creation_date_time': '2026-11-23T10:00:00.000Z',
          'schema_id': {
            'namespace': 'example',
            'name': 'unknown-measure',
            'version': '1.0',
          },
        },
        'body': {
          'some_value': {'value': 312, 'unit': 'lx'},
          'effective_time_frame': {'date_time': '2026-11-23T10:00:00.000Z'},
        },
      };

      final dataPoint = DataPoint.fromJson(json);

      expect(dataPoint.body, isA<GenericMeasure>());
      expect(dataPoint.body.getSchemaId().name, 'unknown-measure');
      expect(dataPoint.body.effectiveTimeFrame?.dateTime, isNotNull);
      expect(jsonDecode(jsonEncode(dataPoint)), equals(json));
    });

    test('reads a registered custom measure', () {
      MeasureFactory.register(_LightLevel.SCHEMA_ID, _LightLevel.fromJson);

      final dataPoint = DataPoint(body: _LightLevel(312));
      final readBack = _roundTrip(dataPoint, DataPoint.fromJson);

      expect(readBack.header.schemaId.namespace, 'example');
      expect(readBack.body, isA<_LightLevel>());
      expect((readBack.body as _LightLevel).lux, 312);
    });
  });

  group('SchemaId and SchemaVersion', () {
    test('parses versions with and without a qualifier', () {
      final version = SchemaVersion.fromString('1.2');
      expect([version.major, version.minor, version.qualifier], [1, 2, null]);

      final qualified = SchemaVersion.fromString('1.0.RC1');
      expect([qualified.major, qualified.minor, qualified.qualifier], [
        1,
        0,
        'RC1',
      ]);
      expect(qualified.toString(), '1.0.RC1');
    });

    test('orders versions', () {
      int compare(String a, String b) =>
          SchemaVersion.fromString(a).compareTo(SchemaVersion.fromString(b));

      expect(compare('1.0', '1.0'), 0);
      expect(compare('1.0', '1.1'), isNegative);
      expect(compare('1.2', '1.10'), isNegative);
      expect(compare('2.0', '1.9'), isPositive);
      expect(compare('1.0.RC1', '1.0.RC2'), isNegative);
      // A pre-release (with a qualifier) comes before the release
      expect(compare('1.0.RC1', '1.0'), isNegative);
      expect(compare('1.0', '1.0.RC1'), isPositive);
    });

    test('formats and reads a schema id', () {
      final schemaId = SchemaId.withVersion(
        SchemaSupport.IEEE_NAMESPACE,
        'deep-sleep',
        SchemaVersion.V1_0,
      );
      expect(schemaId.toString(), 'ieee.deep-sleep.v1.0');
      expect(jsonDecode(jsonEncode(schemaId)), {
        'namespace': 'ieee',
        'name': 'deep-sleep',
        'version': '1.0',
      });
      expect(
        SchemaId.fromJson(
          jsonDecode(jsonEncode(schemaId)) as Map<String, dynamic>,
        ).compareTo(schemaId),
        0,
      );
    });
  });

  group('Date-times in JSON', () {
    test('are written in UTC', () {
      final local = DateTime(2026, 11, 23, 8, 30);
      final json =
          jsonDecode(jsonEncode(TimeFrame(dateTime: local)))
              as Map<String, dynamic>;

      expect(json['date_time'], endsWith('Z'));
      expect(
        DateTime.parse(json['date_time'] as String).isAtSameMomentAs(local),
        isTrue,
        reason: 'The UTC date-time must be the same point in time',
      );
    });

    test('are read as the same point in time', () {
      final local = DateTime(2026, 11, 23, 8, 30);
      final readBack = _roundTrip(
        TimeFrame(dateTime: local),
        TimeFrame.fromJson,
      );
      expect(readBack.dateTime!.isAtSameMomentAs(local), isTrue);
    });

    test('without a time zone are read as UTC', () {
      final timeFrame = TimeFrame.fromJson({
        'date_time': '2026-11-23T08:30:00',
      });
      expect(timeFrame.dateTime, DateTime.utc(2026, 11, 23, 8, 30));
    });

    test('with a time zone offset are read as that point in time', () {
      final timeFrame = TimeFrame.fromJson({
        'date_time': '2026-11-23T09:30:00+01:00',
      });
      expect(
        timeFrame.dateTime!.isAtSameMomentAs(DateTime.utc(2026, 11, 23, 8, 30)),
        isTrue,
      );
    });

    test('are written in UTC in all schemas with date-times', () {
      final local = DateTime(2026, 11, 23, 8, 30);
      final dataPoint = DataPoint(
        body: TotalSleepTime(
          totalSleepTime: DurationUnitValue(DurationUnit.HOUR, 7),
          effectiveTimeFrame: TimeFrame(
            timeInterval: TimeInterval(startDateTime: local, endDateTime: local),
          ),
        ),
        sourceCreationDateTime: local,
      );
      final survey = Survey(
        items: [
          SurveyItem(
            question: SurveyQuestion(text: 'How are you?'),
            askedDateTime: local,
            answeredDateTime: local,
          ),
        ],
        deliveryDetails: SurveyDeliveryDetails(
          startDateTime: local,
          endDateTime: local,
        ),
      )..effectiveTimeFrame = TimeFrame(dateTime: local);

      // All 8 date-time properties: the header, time frame, time interval
      // (2), survey item (2), and survey delivery details (2).
      final dateTimes = RegExp(
        r'"\d{4}-\d{2}-\d{2}T[^"]*"',
      ).allMatches(jsonEncode([dataPoint, survey])).map((m) => m[0]!);
      expect(dateTimes, hasLength(8));
      expect(dateTimes, everyElement(endsWith('Z"')));
    });
  });

  group('Checks when creating objects', () {
    final start = DateTime.utc(2026, 11, 22, 23);
    final end = DateTime.utc(2026, 11, 23, 7);

    test('a time frame is either a date time or a time interval', () {
      expect(() => TimeFrame(), throwsA(isA<AssertionError>()));
      expect(
        () => TimeFrame(
          dateTime: start,
          timeInterval: TimeInterval(startDateTime: start, endDateTime: end),
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(TimeFrame(dateTime: start).dateTime, start);
    });

    test('a time interval has two of start, end, and duration', () {
      final hour = DurationUnitValue(DurationUnit.HOUR, 8);
      expect(
        () => TimeInterval(startDateTime: start),
        throwsA(isA<AssertionError>()),
      );
      expect(
        TimeInterval(startDateTime: start, endDateTime: end).endDateTime,
        end,
      );
      expect(TimeInterval(startDateTime: start, duration: hour).duration, hour);
      expect(TimeInterval(endDateTime: end, duration: hour).duration, hour);
    });

    test('physical activity and sleep require a time interval', () {
      final pointInTime = TimeFrame(dateTime: start);
      expect(
        () => PhysicalActivity(
          activityName: 'walking',
          effectiveTimeFrame: pointInTime,
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => TotalSleepTime(
          totalSleepTime: DurationUnitValue(DurationUnit.HOUR, 7),
          effectiveTimeFrame: pointInTime,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('a frequency is in hertz or a number of times in a time window', () {
      expect(
        () => FrequencyUnitValue(value: 1),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => FrequencyUnitValue(
          numberOfTimes: 2,
          timeWindow: UnitValue('h', 1),
        ),
        throwsA(isA<AssertionError>()),
        reason: 'The time window must be a duration or a duration range',
      );
      expect(FrequencyUnitValue.hertz(0.5).unit, FrequencyUnit.HERTZ);
      expect(
        _roundTrip(
          FrequencyUnitValue.timesInRange(
            numberOfTimes: 1,
            timeWindow: DurationUnitValueRange(
              lowValue: 20,
              highValue: 28,
              unit: DurationUnit.HOUR,
            ),
          ),
          FrequencyUnitValue.fromJson,
        ).timeWindow,
        isA<DurationUnitValueRange>(),
      );
    });

    test('a survey has at least one item', () {
      expect(
        () => Survey(items: [], deliveryDetails: SurveyDeliveryDetails()),
        throwsA(isA<AssertionError>()),
      );
    });

    test('survey answers have the right format', () {
      expect(
        () => SurveyDateAnswer(value: '26-01-02'),
        throwsA(isA<AssertionError>()),
      );
      expect(SurveyDateAnswer(value: '2026-01').value, '2026-01');
      expect(
        SurveyDateAnswer.fromDateTime(DateTime(2026, 1, 2, 13, 45)).value,
        '2026-01-02',
      );

      expect(
        () => SurveyTimeAnswer(value: '24:00'),
        throwsA(isA<AssertionError>()),
      );
      expect(SurveyTimeAnswer(value: '23:59').value, '23:59');

      expect(
        () => SurveyCategoricalAnswer(value: 'Never', code: true),
        throwsA(isA<AssertionError>()),
      );
      expect(SurveyCategoricalAnswer(value: 'Never', code: 1).code, 1);
    });

    test('an ambient light wavelength is in nanometers', () {
      expect(
        () => AmbientLightComponent(
          intensity: IlluminanceUnitValue(value: 10),
          wavelength: LengthUnitValue(LengthUnit.METER, 450),
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}

/// Encodes [object] to JSON and reads it back using [fromJson].
T _roundTrip<T>(Object object, T Function(Map<String, dynamic>) fromJson) =>
    fromJson(jsonDecode(jsonEncode(object)) as Map<String, dynamic>);

BloodPressure _bloodPressure() => BloodPressure(
  systolicBloodPressure: SystolicBloodPressure(
    unit: BloodPressureUnit.MM_OF_MERCURY,
    value: 160,
  ),
  diastolicBloodPressure: DiastolicBloodPressure(
    unit: BloodPressureUnit.MM_OF_MERCURY,
    value: 80,
  ),
  bodyPosture: BodyPosture.SITTING,
)..effectiveTimeFrame = TimeFrame(dateTime: DateTime.utc(2026, 11, 23, 8));

TotalSleepTime _totalSleepTime(double hours) => TotalSleepTime(
  totalSleepTime: DurationUnitValue(DurationUnit.HOUR, hours),
  effectiveTimeFrame: TimeFrame(
    timeInterval: TimeInterval(
      startDateTime: DateTime.utc(2026, 11, 22, 23),
      endDateTime: DateTime.utc(2026, 11, 23, 7),
    ),
  ),
);

/// A measure defined outside this package, in its own namespace.
class _LightLevel extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    'example',
    'light-level',
    SchemaVersion.V1_0,
  );

  final double lux;

  _LightLevel(this.lux);

  factory _LightLevel.fromJson(Map<String, dynamic> json) =>
      _LightLevel((json['lux'] as num).toDouble());

  @override
  Map<String, dynamic> toJson() => {'lux': lux};

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
