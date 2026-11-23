import 'dart:convert';

import 'package:openmhealth_schemas/openmhealth_schemas.dart';

void main() {
  // Create an IEEE 1752.1 physical activity measure.
  final walk = PhysicalActivity(
    activityName: 'walking',
    effectiveTimeFrame: TimeFrame(
      timeInterval: TimeInterval(
        startDateTime: DateTime.utc(2026, 11, 23, 8, 0),
        endDateTime: DateTime.utc(2026, 11, 23, 8, 45),
      ),
    ),
    baseMovementQuantity: UnitValue(BaseMovementUnit.STEPS, 5400),
    distance: LengthUnitValue(LengthUnit.KILOMETER, 4.2),
    kcalBurned: KcalUnitValue(unit: KcalUnit.KILOCALORIE, value: 210),
    reportedActivityIntensity: SelfReportedIntensity.MODERATE,
  );
  print('PhysicalActivity:\n${toJsonString(walk)}');

  // Create an OMH heart rate measure.
  final heartRate = HeartRate(
    heartRate: HeartRateUnitValue(
      unit: HeartRateUnit.BEATS_PER_MINUTE,
      value: 62,
    ),
    temporalRelationshipToPhysicalActivity:
        TemporalRelationshipToPhysicalActivity.AT_REST,
  )..effectiveTimeFrame = TimeFrame(dateTime: DateTime.utc(2026, 11, 23, 7, 30));
  print('\nHeartRate:\n${toJsonString(heartRate)}');

  // Put the heart rate measure in an IEEE 1752.1 data point.
  final dataPoint = DataPoint(
    body: heartRate,
    modality: DataPointModality.SENSED,
  );
  print('\nDataPoint:\n${toJsonString(dataPoint)}');

  // Read the data point back from JSON. The body is created as a HeartRate,
  // based on the schema id in the header.
  final readBack = DataPoint.fromJson(
    json.decode(json.encode(dataPoint)) as Map<String, dynamic>,
  );
  final body = readBack.body as HeartRate;
  print('\nRead back a ${body.runtimeType} of ${body.heartRate.value} '
      '${body.heartRate.unit}');
}

/// Converts [object] to a formatted JSON string.
String toJsonString(Object object) =>
    const JsonEncoder.withIndent('  ').convert(object);
