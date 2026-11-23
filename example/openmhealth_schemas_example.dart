import 'package:openmhealth_schemas/openmhealth_schemas.dart';
import 'dart:convert';

void main() {
  // Creating an OMH [BloodPressure] measure similar to the one shown at
  // https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_blood-pressure
  BloodPressure bp = BloodPressure(
    systolicBloodPressure: SystolicBloodPressure(
      unit: BloodPressureUnit.MM_OF_MERCURY,
      value: 160.0,
    ),
    diastolicBloodPressure: DiastolicBloodPressure(
      unit: BloodPressureUnit.MM_OF_MERCURY,
      value: 80.0,
    ),
    bodyPosture: BodyPosture.SITTING,
  );

  DateTime start = DateTime.utc(2016, 2, 5);
  DateTime end = DateTime.utc(2016, 6, 5);
  TimeInterval time = TimeInterval(startDateTime: start, endDateTime: end);
  bp.effectiveTimeFrame = TimeFrame(timeInterval: time);
  bp.descriptiveStatistic = DescriptiveStatistic.MAXIMUM;

  // Now convert this to JSON
  print("\nBloodPressure:\n${_encode(bp)}");

  // Similarly - create an OMH [Geoposition] object, convert it to JSON and print it.
  Geoposition position = Geoposition(
    latitude: PlaneAngleUnitValue(
      unit: PlaneAngleUnit.DEGREE_OF_ARC,
      value: 40.059692382,
    ),
    longitude: PlaneAngleUnitValue(
      unit: PlaneAngleUnit.DEGREE_OF_ARC,
      value: -105.21440124511719,
    ),
    elevation: LengthUnitValue(LengthUnit.METER, 1548.5),
  );

  position.positioningSystem = PositioningSystem.GPS;
  position.effectiveTimeFrame = TimeFrame(dateTime: DateTime.now().toUtc());
  print("\nGeoposition:\n${_encode(position)}");

  // Create an IEEE 1752.1 [PhysicalActivity].
  PhysicalActivity walk = PhysicalActivity(
    activityName: 'walking',
    effectiveTimeFrame: TimeFrame(
      timeInterval: TimeInterval(
        startDateTime: DateTime.utc(2026, 11, 23, 8),
        endDateTime: DateTime.utc(2026, 11, 23, 9),
      ),
    ),
    baseMovementQuantity: UnitValue(BaseMovementUnit.STEPS, 5400),
    distance: LengthUnitValue(LengthUnit.KILOMETER, 4.2),
    kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 210),
  );
  print("\nPhysicalActivity:\n${_encode(walk)}");

  // Creating IEEE 1752.1 data points ready to be uploaded to a server.
  // The body of a data point can be both an IEEE and an OMH measure.

  // First, the data point for the blood pressure measure.
  DataPoint dp_1 = DataPoint(body: bp);
  print("\nDataPoint_BloodPressure:\n${_encode(dp_1)}");

  // Then the data point for the geo position measure.
  DataPoint dp_2 = DataPoint(
    body: position,
    modality: DataPointModality.SENSED,
    externalDatasheets: [
      ExternalDatasheet(
        datasheetType: 'hardware',
        datasheetReference: 'Android Nexus Phone',
      ),
    ],
  );
  print("\nDataPoint_Geoposition:\n${_encode(dp_2)}");

  // Finally, read a JSON string and convert it into a Dart object.
  final act_1 = PhysicalActivity.fromJson(
    json.decode(ieeePhysicalActivity) as Map<String, dynamic>,
  );

  print(
    "\nA person has been ${act_1.activityName} ${act_1.distance?.value} ${act_1.distance?.unit}",
  );
}

String _encode(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);

// An IEEE 1752.1 physical activity JSON example.
const String ieeePhysicalActivity =
    '{"activity_name": "walking", "distance": {"value": 3.1, "unit": "mi"}, "effective_time_frame": {"time_interval": {"start_date_time": "2015-02-06T06:25:00Z", "end_date_time": "2015-02-06T07:25:00Z"}}, "kcal_burned": {"value": 160, "unit": "kcal"}, "met_value": 3.5}';
