import 'package:test/test.dart';
import 'dart:convert';
import 'package:openmhealth_schemas/openmhealth_schemas.dart';
import 'dart:io';

void main() {
  group('OMH Schema Tests', () {
    test('- geoposition', () {
      //Trying to create the example from OMH
      var position = Geoposition(
        latitude: PlaneAngleUnitValue(
          value: 40.059692382,
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
        ),
        longitude: PlaneAngleUnitValue(
          value: -105.21440124511719,
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
        ),
        elevation: LengthUnitValue((LengthUnit.METER), 1548.5),
      );

      expect(position.elevation!.value, 1548.5);

      print(position.latitude.toString());
      print(position.longitude.toString());
      print(position.elevation.toString());
    });

    test('- physical activity', () {
      //Just creating a PhysicalActivity
      var activity = PhysicalActivity(
        activityName: 'Coding OMH schemas',
        caloriesBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 320.0),
        reportedActivityIntensity: SelfReportedIntensity.LIGHT,
        distance: LengthUnitValue((LengthUnit.METER), 12.0),
      );
      expect(activity.reportedActivityIntensity, 'light');

      var cal = CaloriesBurned(
        kcalBurned: KcalUnitValue(unit: (KcalUnit.KILOCALORIE), value: 23.2),
      );
      expect(cal.kcalBurned.value, 23.2);

      var mma = MinutesModerateActivity(
        minutesModerateActivity: DurationUnitValue(DurationUnit.MINUTE, 12.3),
      );
      expect(mma.minutesModerateActivity.value, 12.3);
    });

    test('- step count', () {
      // Creating the omh 'with average' example;
      var steps = StepCount(stepCount: 12000);
      steps.descriptiveStatistic = DescriptiveStatistic.AVERAGE;
      steps.descriptiveStatisticDenominator =
          DescriptiveStatisticDenominator.DAY;
      var start = DateTime(2016, 5, 5);
      var end = DateTime(2016, 6, 5);
      var time = TimeInterval(startDateTime: start, endDateTime: end);
      steps.effectiveTimeFrame = TimeFrame(timeInterval: time);

      expect(steps.stepCount, 12000);
      expect(steps.effectiveTimeFrame!.dateTime, null);
      expect(steps.effectiveTimeFrame!.timeInterval!.startDateTime, start);
      expect(steps.effectiveTimeFrame!.timeInterval!.endDateTime, end);
    });

    test('- acceleration', () {
      // Creating the omh 'with average' example;
      var acc = Acceleration(
        acceleration_x: AccelerationUnitValue(
          unit: AccelerationUnit.M_S2,
          value: 9.82,
        ),
        acceleration_y: AccelerationUnitValue(
          unit: AccelerationUnit.M_S2,
          value: -9.82,
        ),
        acceleration_z: AccelerationUnitValue(
          unit: AccelerationUnit.M_S2,
          value: 0.0001,
        ),
        sensor_body_location: BodyLocation.RIGHT_HIP,
      );

      var start = DateTime(2016, 5, 5);
      var end = DateTime(2016, 6, 5);
      var time = TimeInterval(startDateTime: start, endDateTime: end);
      acc.effectiveTimeFrame = TimeFrame(timeInterval: time);

      expect(acc.sensor_body_location, 'right hip');
      expect(acc.effectiveTimeFrame!.dateTime, null);
      expect(acc.effectiveTimeFrame!.timeInterval!.startDateTime, start);
      expect(acc.effectiveTimeFrame!.timeInterval!.endDateTime, end);
    });

    test('- blood pressure', () {
      //Testing
      var bp = BloodPressure(
        systolicBloodPressure: SystolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 160.0,
        ),
        diastolicBloodPressure: DiastolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 80.0,
        ),
        positionDuringMeasurement: PositionDuringMeasurement.SITTING,
      );

      expect(bp.diastolicBloodPressure.value, 80);
      expect(bp.systolicBloodPressure.value, 160);
      expect(bp.positionDuringMeasurement, 'sitting');
    });

    test('- heart rate', () {
      var hr = HeartRate(
        heartRate: HeartRateUnitValue(
          unit: HeartRateUnit.BEATS_PER_MINUTE,
          value: 50.0,
        ),
      );
      hr.userNotes = 'I felt quite dizzy';
      hr.effectiveTimeFrame = TimeFrame(dateTime: DateTime.now());

      expect(hr.heartRate.value, 50);
      expect(hr.userNotes, isNotNull);

      print('\nHeartRate:\n${_encode(hr)}');
    });

    test('- survey', () {
      var survey = Survey(
        deliveryDetails: SurveyDeliveryDetails(
          startDateTime: DateTime(1998),
          endDateTime: DateTime.now(),
          endStatus: SurveyEndStatus.COMPLETED,
        ),
      );

      var item_1 = SurveyItem(
        question: SurveyQuestion(text: 'How are you doing?'),
        answeredDateTime: DateTime.now(),
        askedDateTime: DateTime.now(),
      );
      item_1.answers.add(
        SurveyCategoricalAnswer(value: ({'1': 'Fine, thank you', '2': 'OK'})),
      );

      var item_2 = SurveyItem(
        question: SurveyQuestion(
          text: "When was the '99 Lufttbaloons' album released?",
        ),
        answeredDateTime: DateTime.now(),
        askedDateTime: DateTime.now(),
      );
      item_2.answeredDateTime = DateTime.now();
      item_2.answers.add(SurveyDateAnswer(value: DateTime(1984)));

      survey.items.add(item_1);
      survey.items.add(item_2);

      survey.deliveryDetails = SurveyDeliveryDetails(
        startDateTime: DateTime(1998),
        endDateTime: DateTime.now(),
        endStatus: SurveyEndStatus.COMPLETED,
      );

      expect(survey.items.length, 2);
      expect(survey.deliveryDetails, isNotNull);

      print('\nSurvey:\n${_encode(survey)}');
    });
  });

  group('JSON De-/serialization', () {
    test('- all measures except survey', () async {
      final measures = [
        // Acceleration measure
        Acceleration(
          acceleration_x: AccelerationUnitValue(
            unit: AccelerationUnit.M_S2,
            value: 9.82,
          ),
          acceleration_y: AccelerationUnitValue(
            unit: AccelerationUnit.M_S2,
            value: 0.0,
          ),
          acceleration_z: AccelerationUnitValue(
            unit: AccelerationUnit.M_S2,
            value: 0.0,
          ),
          sensor_body_location: BodyLocation.RIGHT_HIP,
        ),

        // Activity measures
        PhysicalActivity(
          activityName: 'walking',
          caloriesBurned: KcalUnitValue(
            unit: KcalUnit.KILOCALORIE,
            value: 320.0,
          ),
          reportedActivityIntensity: SelfReportedIntensity.LIGHT,
          distance: LengthUnitValue((LengthUnit.METER), 12.0),
        ),

        StepCount(stepCount: 12000)
          ..descriptiveStatistic = DescriptiveStatistic.AVERAGE
          ..descriptiveStatisticDenominator =
              DescriptiveStatisticDenominator.DAY
          ..effectiveTimeFrame = TimeFrame(
            timeInterval: TimeInterval(
              startDateTime: DateTime(2016, 5, 5),
              endDateTime: DateTime(2016, 6, 5),
            ),
          ),

        CaloriesBurned(
          activityName: 'running',
          kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 23.2),
          descriptiveStatisticDenominator: 'session',
        ),

        MinutesModerateActivity(
          minutesModerateActivity: DurationUnitValue(
            (DurationUnit.MINUTE),
            12.3,
          ),
        ),

        // Blood Pressure measure
        BloodPressure(
          systolicBloodPressure: SystolicBloodPressure(
            unit: BloodPressureUnit.MM_OF_MERCURY,
            value: 160.0,
          ),
          diastolicBloodPressure: DiastolicBloodPressure(
            unit: BloodPressureUnit.MM_OF_MERCURY,
            value: 80.0,
          ),
          positionDuringMeasurement: PositionDuringMeasurement.SITTING,
        ),

        // Cardio measures
        HeartRate(
          heartRate: HeartRateUnitValue(
            unit: HeartRateUnit.BEATS_PER_MINUTE,
            value: 50.0,
          ),
          temporalRelationshipToPhysicalActivity: 'after exercise',
          temporalRelationshipToSleep: 'just before sleep',
        ),

        RrInterval(
          rrInterval: RrInterUnitValue(value: 30, unit: 'millisecond'),
          temporalRelationshipToPhysicalActivity: 'resting',
        ),

        // Geoposition measure
        Geoposition(
          longitude: PlaneAngleUnitValue(
            unit: PlaneAngleUnit.DEGREE_OF_ARC,
            value: 40.059692382,
          ),
          latitude: PlaneAngleUnitValue(
            unit: PlaneAngleUnit.DEGREE_OF_ARC,
            value: -105.21440124511719,
          ),
          elevation: LengthUnitValue((LengthUnit.METER), 1548.5),
        ),
      ];

      final measuresEncoded = <Map<String, dynamic>>[];
      for (var data in measures) {
        final dataJson = _encode(data);
        print(dataJson);
        measuresEncoded.add(json.decode(dataJson) as Map<String, dynamic>);
      }

      final measuresDecoded = <Measure>[];

      measuresDecoded.add(Acceleration.fromJson(measuresEncoded[0]));
      measuresDecoded.add(PhysicalActivity.fromJson(measuresEncoded[1]));
      measuresDecoded.add(StepCount.fromJson(measuresEncoded[2]));
      measuresDecoded.add(CaloriesBurned.fromJson(measuresEncoded[3]));
      measuresDecoded.add(MinutesModerateActivity.fromJson(measuresEncoded[4]));
      measuresDecoded.add(BloodPressure.fromJson(measuresEncoded[5]));
      measuresDecoded.add(HeartRate.fromJson(measuresEncoded[6]));
      measuresDecoded.add(RrInterval.fromJson(measuresEncoded[7]));
      measuresDecoded.add(Geoposition.fromJson(measuresEncoded[8]));

      for (var i = 0; i < measures.length; i++) {
        expect(
          _encode(measuresDecoded[i]),
          equals(_encode(measuresEncoded[i])),
        );
      }
    });

    test('- survey measures w/o answers', () async {
      final item = SurveyItem(
        question: SurveyQuestion(text: 'How are you doing?'),
        answeredDateTime: DateTime.now(),
        askedDateTime: DateTime.now(),
      );

      final survey =
          Survey(
              deliveryDetails: SurveyDeliveryDetails(
                startDateTime: DateTime(1998),
                endDateTime: DateTime.now(),
                endStatus: SurveyEndStatus.COMPLETED,
              ),
              score: DiastolicBloodPressure(unit: 'mmHg', value: 90.0),
            )
            ..items = [
              SurveyItem(
                question: SurveyQuestion(text: 'How are you doing?'),
                answeredDateTime: DateTime.now(),
                askedDateTime: DateTime.now(),
              ),
              SurveyItem(
                question: SurveyQuestion(
                  text: "When was the '99 Lufttbaloons' album released?",
                ),
                answeredDateTime: DateTime.now(),
                askedDateTime: DateTime.now(),
              ),
            ];

      expect(
        _encode(
          SurveyItem.fromJson(
            json.decode(_encode(item)) as Map<String, dynamic>,
          ),
        ),
        equals(_encode(item)),
      );

      expect(
        _encode(
          Survey.fromJson(json.decode(_encode(survey)) as Map<String, dynamic>),
        ),
        equals(_encode(survey)),
      );
    });

    // Tests including answers. Will fail until polymorphic deserialization is supported.
    // See issue: #4
    test('- survey measures', () async {
      final item =
          SurveyItem(
              question: SurveyQuestion(text: 'How are you doing?'),
              answeredDateTime: DateTime.now(),
              askedDateTime: DateTime.now(),
            )
            ..answers = [
              SurveyCategoricalAnswer(
                value: ({'1': 'Fine, thank you', '2': 'OK'}),
              ),
            ];

      final survey =
          Survey(
              deliveryDetails: SurveyDeliveryDetails(
                startDateTime: DateTime(1998),
                endDateTime: DateTime.now(),
                endStatus: SurveyEndStatus.COMPLETED,
              ),
              score: DiastolicBloodPressure(unit: 'mmHg', value: 90.0),
            )
            ..items = [
              SurveyItem(
                  question: SurveyQuestion(text: 'How are you doing?'),
                  answeredDateTime: DateTime.now(),
                  askedDateTime: DateTime.now(),
                )
                ..answers = [
                  SurveyCategoricalAnswer(
                    value: ({'1': 'Fine, thank you', '2': 'OK'}),
                  ),
                ],
              SurveyItem(
                question: SurveyQuestion(
                  text: "When was the '99 Lufttbaloons' album released?",
                ),
                answeredDateTime: DateTime.now(),
                askedDateTime: DateTime.now(),
              )..answers = [SurveyDateAnswer(value: DateTime(1984))],
            ];

      expect(
        _encode(
          SurveyItem.fromJson(
            json.decode(_encode(item)) as Map<String, dynamic>,
          ),
        ),
        equals(_encode(item)),
      );

      expect(
        _encode(
          Survey.fromJson(json.decode(_encode(survey)) as Map<String, dynamic>),
        ),
        equals(_encode(survey)),
      );
    });

    test('... schema serialization', () {
      var bp_1 = BloodPressure(
        systolicBloodPressure: SystolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 160.0,
        ),
        diastolicBloodPressure: DiastolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 80.0,
        ),
        positionDuringMeasurement: PositionDuringMeasurement.SITTING,
      );

      print('\nBloodPressure:\n${_encode(bp_1)}');

      var position = Geoposition(
        longitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: 40.059692382,
        ),
        latitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: -105.21440124511719,
        ),
        elevation: LengthUnitValue((LengthUnit.METER), 1548.5),
      );

      position.positioningSystem = PositioningSystem.GPS;

      print('Geoposition:\n${_encode(position)}');

      var activity = PhysicalActivity(
        activityName: 'walking',
        caloriesBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 320.0),
        reportedActivityIntensity: SelfReportedIntensity.LIGHT,
        distance: LengthUnitValue((LengthUnit.METER), 12.0),
      );

      print('\nPhysicalActivity:\n${_encode(activity)}');

      var steps = StepCount(stepCount: 12000);
      steps.descriptiveStatistic = DescriptiveStatistic.AVERAGE;
      steps.descriptiveStatisticDenominator =
          DescriptiveStatisticDenominator.DAY;
      var start = DateTime(2016, 5, 5);
      var end = DateTime(2016, 6, 5);
      var time = TimeInterval(startDateTime: start, endDateTime: end);
      steps.effectiveTimeFrame = TimeFrame(timeInterval: time);

      print('\nStepCount:\n${_encode(steps)}');

      var cal = CaloriesBurned(
        kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 23.2),
      );

      print('CaloriesBurned:\n${_encode(cal)}');

      var mma = MinutesModerateActivity(
        minutesModerateActivity: DurationUnitValue((DurationUnit.MINUTE), 12.3),
      );

      print('MinutesModerateActivity\n${_encode(mma)}');
    });

    test(' - DataPoint serialization', () {
      var bp = BloodPressure(
        systolicBloodPressure: SystolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 160.0,
        ),
        diastolicBloodPressure: DiastolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 80.0,
        ),
        positionDuringMeasurement: PositionDuringMeasurement.SITTING,
      );

      var dp_1 = DataPoint(body: bp);

      print('\nDataPoint_BloodPressure:\n${_encode(dp_1)}');

      var position = Geoposition(
        longitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: 40.059692382,
        ),
        latitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: -105.21440124511719,
        ),
        elevation: LengthUnitValue((LengthUnit.METER), 1548.5),
      );

      var dp_2 = DataPoint(
        body: position,
        userId: 'bardram',
        provenance: DataPointAcquisitionProvenance(
          sourceName: 'Android Nexus Phone',
          modality: DataPointModality.SENSED,
        ),
      );

      print('\nDataPoint_Geoposition:\n${_encode(dp_2)}');
    });

    test(' - DataPoint deserialization', () {
      var bp = BloodPressure(
        systolicBloodPressure: SystolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 160.0,
        ),
        diastolicBloodPressure: DiastolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 80.0,
        ),
        positionDuringMeasurement: PositionDuringMeasurement.SITTING,
      );

      var dp_1 = DataPoint(body: bp);
      print(_encode(dp_1));

      expect(
        _encode(
          DataPoint.fromJson(
            json.decode(_encode(dp_1)) as Map<String, dynamic>,
          ),
        ),
        equals(_encode(dp_1)),
      );
    });

    test('... schema de-/serialization', () {
      var uv_1 = UnitValue('mmHg', 120.2);
      final uv_1_json = _encode(uv_1);
      print('\nUnit Value:\n$uv_1_json');
      final uv_2 = UnitValue.fromJson(
        json.decode(uv_1_json) as Map<String, dynamic>,
      );
      expect(uv_2.value, uv_1.value);
      expect(_encode(uv_2), equals(uv_1_json));

      var luv_1 = LengthUnitValue(LengthUnit.METER, 10.2);
      final luv_1_json = _encode(luv_1);
      print('\nLength Unit Value:\n$luv_1_json');
      final luv_2 = LengthUnitValue.fromJson(
        json.decode(luv_1_json) as Map<String, dynamic>,
      );
      expect(_encode(luv_2), equals(luv_1_json));

      var p_1 = Geoposition(
        longitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: 40.059692382,
        ),
        latitude: PlaneAngleUnitValue(
          unit: PlaneAngleUnit.DEGREE_OF_ARC,
          value: -105.21440124511719,
        ),
        elevation: LengthUnitValue((LengthUnit.METER), 1548.5),
      );
      p_1.positioningSystem = PositioningSystem.GPS;
      final p_1_json = _encode(p_1);
      print('Geoposition:\n$p_1_json');

      final p_2 = Geoposition.fromJson(
        json.decode(p_1_json) as Map<String, dynamic>,
      );
      expect(p_2.longitude.value, p_1.longitude.value);
      expect(_encode(p_2), equals(p_1_json));

      var bp_1 = BloodPressure(
        systolicBloodPressure: SystolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 160.0,
        ),
        diastolicBloodPressure: DiastolicBloodPressure(
          unit: BloodPressureUnit.MM_OF_MERCURY,
          value: 80.0,
        ),
        positionDuringMeasurement: PositionDuringMeasurement.SITTING,
      );

      final bp_1_json = _encode(bp_1);
      print('\nBloodPressure:\n$bp_1_json');
      final bp_2 = BloodPressure.fromJson(
        json.decode(bp_1_json) as Map<String, dynamic>,
      );
      expect(_encode(bp_2), equals(bp_1_json));

      var act_1 = PhysicalActivity(
        activityName: 'walking',
        caloriesBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 320.0),
        reportedActivityIntensity: SelfReportedIntensity.LIGHT,
        distance: LengthUnitValue((LengthUnit.METER), 12.0),
      );

      act_1.effectiveTimeFrame = TimeFrame(dateTime: DateTime.now());

      final act_1_json = _encode(act_1);
      print('\nPhysicalActivity:\n${_encode(act_1)}');
      final act_2 = PhysicalActivity.fromJson(
        json.decode(act_1_json) as Map<String, dynamic>,
      );
      expect(_encode(act_2), equals(act_1_json));

      var cal_1 = CaloriesBurned(
        kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 23.2),
      );

      final cal_1_json = _encode(cal_1);
      print('\nCaloriesBurned:\n${_encode(cal_1)}');
      final cal_2 = CaloriesBurned.fromJson(
        json.decode(cal_1_json) as Map<String, dynamic>,
      );
      expect(_encode(cal_2), equals(cal_1_json));

      var mma_1 = MinutesModerateActivity(
        minutesModerateActivity: DurationUnitValue((DurationUnit.MINUTE), 12.3),
      );

      final mma_1_json = _encode(mma_1);
      print('\nMinutesModerateActivity\n${_encode(mma_1)}');
      final mma_2 = MinutesModerateActivity.fromJson(
        json.decode(mma_1_json) as Map<String, dynamic>,
      );
      expect(_encode(mma_2), equals(mma_1_json));
    });

    // The data is various OMH JSON examples from the OMH website.
    // Testing if we can load these.
    group('Reading OMH Schemas', () {
      test(' - physical activity', () {
        final str = File('test/json/physical_activity.json').readAsStringSync();

        final measure = PhysicalActivity.fromJson(
          json.decode(str) as Map<String, dynamic>,
        );
        print(_encode(measure));
        expect(measure.activityName, 'walking');
        expect(measure.distance!.value, 3.1);
      });
      test(' - blood pressure', () {
        final str = File('test/json/blood_pressure.json').readAsStringSync();

        final measure = BloodPressure.fromJson(
          json.decode(str) as Map<String, dynamic>,
        );
        print(_encode(measure));
        expect(measure.systolicBloodPressure.value, 160.0);
        expect(measure.diastolicBloodPressure.value, 60.0);
      });
    });

    test(' - data point', () {
      final str = File('test/json/data_point.json').readAsStringSync();

      final measure = DataPoint.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );
      print(_encode(measure));
      expect(measure.header.schemaId.name, 'physical-activity');
      // this fails because polymorphic deserialization is not yet supported for Measure
      expect(measure.body, isA<PhysicalActivity>());
    });
  });
}

/// Converts [object] to a formatted JSON [String].
String _encode(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);
