# Open mHealth Schemas for Dart

<p>
  <a href="https://carp.dk"><img align="right" width="166" height="70" src="images/carp-x-dtu-logo.svg" alt="CARP x DTU"></a>
  <a href="https://pub.dev/packages/openmhealth_schemas"><img src="https://img.shields.io/pub/v/openmhealth_schemas?logo=dart&amp;logoColor=white&amp;label=pub&amp;color=0175C2" alt="pub version"></a>
  <a href="https://pub.dev/packages/openmhealth_schemas/score"><img src="https://img.shields.io/pub/points/openmhealth_schemas" alt="pub points"></a>
  <a href="https://pub.dev/packages/openmhealth_schemas/score"><img src="https://img.shields.io/pub/likes/openmhealth_schemas" alt="pub likes"></a>
  <a href="https://pub.dev/packages/openmhealth_schemas"><img src="https://img.shields.io/badge/platform-dart%20%7C%20flutter-lightgrey" alt="Dart and Flutter"></a>
  <br>
  <a href="#ieee-17521-schemas"><img src="https://img.shields.io/badge/IEEE-1752.1-00629B" alt="IEEE 1752.1"></a>
  <a href="#omh-schemas"><img src="https://img.shields.io/badge/Open%20mHealth-schemas-orange" alt="Open mHealth schemas"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/carp-dk/openmhealth_schemas?color=blue" alt="License: MIT"></a>
  <br clear="right">
</p>

A Dart implementation of the [IEEE 1752.1](https://opensource.ieee.org/omh/1752) standard for mobile health data, and of the [Open mHealth](https://github.com/openmhealth/schemas) (OMH) schemas which are not (yet) part of this standard, made by the [Copenhagen Research Platform (CARP)](https://carp.dk) at the [Technical University of Denmark (DTU)](https://dtu.dk).

IEEE 1752.1 standardizes the core of Open mHealth, i.e., the data point and header used to exchange health data, the utility schemas (unit values, time frames, etc.), and the schemas for physical activity, sleep, environment, and surveys.
The OMH schemas for other measures, such as heart rate and blood pressure, are still maintained by Open mHealth.
These OMH schemas are based on the IEEE 1752.1 utility schemas, and OMH measures can be used as the body of an IEEE 1752.1 data point.

This package supports both sets of schemas:

* The [IEEE 1752.1 schemas](#ieee-17521-schemas), which use the `ieee` namespace.
* The [OMH schemas](#omh-schemas) that are not part of IEEE 1752.1, which use the `omh` namespace.

All schemas can be created as Dart objects, converted to JSON, and read back from JSON.
The package is pure Dart and can be used both in Flutter apps and in Dart server or command-line applications.

## Supported Schemas

### IEEE 1752.1 Schemas

All IEEE 1752.1 schemas are supported, in version 1.0.

| Category | Schema | Dart class |
| --- | --- | --- |
| Metadata | [data-point](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/data-point-1.0.json) | `DataPoint` |
| | [data-series](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/data-series-1.0.json) | `DataSeries` |
| | [header](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/header-1.0.json) | `DataPointHeader` |
| | [schema-id](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/metadata/schema-id-1.0.json) | `SchemaId` |
| Physical activity | [physical-activity](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/physical_activity/physical-activity-1.0.json) | `PhysicalActivity` |
| Sleep | [apnea-hypopnea-index](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/apnea-hypopnea-index-1.0.json) | `ApneaHypopneaIndex` |
| | [arousal-index](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/arousal-index-1.0.json) | `ArousalIndex` |
| | [deep-sleep](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/deep-sleep-1.0.json) | `DeepSleep` |
| | [light-sleep](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/light-sleep-1.0.json) | `LightSleep` |
| | [sleep-episode](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-episode-1.0.json) | `SleepEpisode` |
| | [sleep-onset-latency](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-onset-latency-1.0.json) | `SleepOnsetLatency` |
| | [sleep-stage-summary](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-stage-summary-1.0.json) | `SleepStageSummary` |
| | [snore-index](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/snore-index-1.0.json) | `SnoreIndex` |
| | [time-in-bed](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/time-in-bed-1.0.json) | `TimeInBed` |
| | [total-sleep-time](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/total-sleep-time-1.0.json) | `TotalSleepTime` |
| | [wake-after-sleep-onset](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/wake-after-sleep-onset-1.0.json) | `WakeAfterSleepOnset` |
| Environment | [ambient-light](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-light-1.0.json) | `AmbientLight` |
| | [ambient-sound](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-sound-1.0.json) | `AmbientSound` |
| | [ambient-temperature](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-temperature-1.0.json) | `AmbientTemperature` |
| Survey | [survey](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-1.0.json) | `Survey` |
| | [survey-item](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-item-1.0.json) | `SurveyItem` |
| | [survey-question](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-question-1.0.json) | `SurveyQuestion` |
| | [survey-answer](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-answer-1.0.json) | `SurveyAnswer` |
| | [survey-categorical-answer](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-categorical-answer-1.0.json) | `SurveyCategoricalAnswer` |
| | [survey-date-answer](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-date-answer-1.0.json) | `SurveyDateAnswer` |
| | [survey-time-answer](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-time-answer-1.0.json) | `SurveyTimeAnswer` |
| | [survey-unit-value-answer](https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-unit-value-answer-1.0.json) | `SurveyUnitValueAnswer` |
| [Utility](https://opensource.ieee.org/omh/1752/-/tree/main/schemas/utility) | unit values | `UnitValue`, `UnitValueRange`, `DurationUnitValue`, `DurationUnitValueRange`, `FrequencyUnitValue`, `IlluminanceUnitValue`, `KcalUnitValue`, `LengthUnitValue`, `PercentUnitValue`, `SoundUnitValue`, `SpeedUnitValue`, `TemperatureUnitValue` |
| | time | `TimeFrame`, `TimeInterval`, and Dart's `DateTime` for date-time |
| | values | `BodyPosture`, `DescriptiveStatistic`, `DescriptiveStatisticDenominator` |

### OMH Schemas

The OMH schemas which are not part of IEEE 1752.1 are supported in their latest version.

| Category | Schema | Version | Dart class |
| --- | --- | --- | --- |
| Cardiovascular | [blood-pressure](https://github.com/openmhealth/schemas/blob/main/schema/omh/blood-pressure-4.0.json) | 4.0 | `BloodPressure` |
| | [systolic-blood-pressure](https://github.com/openmhealth/schemas/blob/main/schema/omh/systolic-blood-pressure-1.1.json) | 1.1 | `SystolicBloodPressure` |
| | [diastolic-blood-pressure](https://github.com/openmhealth/schemas/blob/main/schema/omh/diastolic-blood-pressure-1.1.json) | 1.1 | `DiastolicBloodPressure` |
| | [heart-rate](https://github.com/openmhealth/schemas/blob/main/schema/omh/heart-rate-3.0.json) | 3.0 | `HeartRate` |
| | [rr-interval](https://github.com/openmhealth/schemas/blob/main/schema/omh/rr-interval-2.0.json) | 2.0 | `RrInterval` |
| Physical activity | [calories-burned](https://github.com/openmhealth/schemas/blob/main/schema/omh/calories-burned-3.0.json) | 3.0 | `CaloriesBurned` |
| Motion and location | [acceleration](https://github.com/openmhealth/schemas/blob/main/schema/omh/acceleration-2.0.json) | 2.0 | `Acceleration` |
| | [acceleration-unit-value](https://github.com/openmhealth/schemas/blob/main/schema/omh/acceleration-unit-value-1.1.json) | 1.1 | `AccelerationUnitValue` |
| | [geoposition](https://github.com/openmhealth/schemas/blob/main/schema/omh/geoposition-2.0.json) | 2.0 | `Geoposition` |
| | [plane-angle-unit-value](https://github.com/openmhealth/schemas/blob/main/schema/omh/plane-angle-unit-value-1.1.json) | 1.1 | `PlaneAngleUnitValue` |
| Values | [body-location](https://github.com/openmhealth/schemas/blob/main/schema/omh/body-location-1.1.json) | 1.1 | `BodyLocation` |
| | [day-of-week](https://github.com/openmhealth/schemas/blob/main/schema/omh/day-of-week-1.0.json) | 1.0 | `DayOfWeek` |
| | [part-of-day](https://github.com/openmhealth/schemas/blob/main/schema/omh/part-of-day-1.0.json) | 1.0 | `PartOfDay` |
| | [temporal-relationship-to-meal](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-meal-1.2.json) | 1.2 | `TemporalRelationshipToMeal` |
| | [temporal-relationship-to-physical-activity](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-physical-activity-1.0.json) | 1.0 | `TemporalRelationshipToPhysicalActivity` |
| | [temporal-relationship-to-sleep](https://github.com/openmhealth/schemas/blob/main/schema/omh/temporal-relationship-to-sleep-1.0.json) | 1.0 | `TemporalRelationshipToSleep` |

## Getting Started

Add the package to your project:

```shell
dart pub add openmhealth_schemas
```

or, in a Flutter app:

```shell
flutter pub add openmhealth_schemas
```

Then import it:

```dart
import 'package:openmhealth_schemas/openmhealth_schemas.dart';
```

## Usage

The examples below are also available in the [example](example/openmhealth_schemas_example.dart).

### Creating Measures

A measure is created using the constructor of its Dart class.
For example, an IEEE 1752.1 physical activity:

```dart
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
```

or an OMH heart rate:

```dart
final heartRate = HeartRate(
  heartRate: HeartRateUnitValue(
    unit: HeartRateUnit.BEATS_PER_MINUTE,
    value: 62,
  ),
  temporalRelationshipToPhysicalActivity:
      TemporalRelationshipToPhysicalActivity.AT_REST,
)..effectiveTimeFrame = TimeFrame(dateTime: DateTime.utc(2026, 11, 23, 7, 30));
```

Units and values defined by the schemas, such as `LengthUnit.KILOMETER` and `SelfReportedIntensity.MODERATE`, are available as constants.

### Converting to JSON

All schemas can be converted to JSON using `toJson()`, or directly using `json.encode()` from `dart:convert`:

```dart
print(const JsonEncoder.withIndent('  ').convert(walk));
```

which gives:

```json
{
  "effective_time_frame": {
    "time_interval": {
      "start_date_time": "2026-11-23T08:00:00.000Z",
      "end_date_time": "2026-11-23T08:45:00.000Z"
    }
  },
  "activity_name": "walking",
  "base_movement_quantity": {
    "value": 5400.0,
    "unit": "steps"
  },
  "distance": {
    "value": 4.2,
    "unit": "km"
  },
  "kcal_burned": {
    "value": 210.0,
    "unit": "kcal"
  },
  "reported_activity_intensity": "moderate"
}
```

Date-times are always written in UTC, i.e., a local `DateTime` is converted to UTC.
This is the same point in time, but avoids that other systems read it wrongly, since IEEE 1752.1 defines that a date-time without a time zone is in UTC.

### Creating Data Points

A `DataPoint` holds a measure in its `body`, and a `header` with information about the data.
The header is created automatically, with a unique id (UUID), the schema id of the measure, and the current time as creation time:

```dart
final dataPoint = DataPoint(
  body: heartRate,
  modality: DataPointModality.SENSED,
);
```

which gives the following JSON:

```json
{
  "header": {
    "uuid": "97db5638-0638-4ce6-a0fa-c9a7c45bac0e",
    "schema_id": {
      "namespace": "omh",
      "name": "heart-rate",
      "version": "3.0"
    },
    "source_creation_date_time": "2026-11-23T19:55:00.982552Z",
    "modality": "sensed"
  },
  "body": {
    "effective_time_frame": {
      "date_time": "2026-11-23T07:30:00.000Z"
    },
    "heart_rate": {
      "value": 62.0,
      "unit": "beats/min"
    },
    "temporal_relationship_to_physical_activity": "at rest"
  }
}
```

Note that the header is an IEEE 1752.1 header, while the body is an OMH heart rate, as identified by the schema id in the header.
The header can also hold the rate at which data is acquired (`acquisitionRate`) and references to documentation of, e.g., the device or study (`externalDatasheets`).

A list of measures of the same schema can share one header in a `DataSeries`:

```dart
final series = DataSeries(
  body: [heartRate1, heartRate2, heartRate3],
  acquisitionRate: FrequencyUnitValue.hertz(1),
);
```

### Reading from JSON

All schemas can be read from JSON using the `fromJson` constructor of the Dart class:

```dart
final activity = PhysicalActivity.fromJson(
  json.decode(jsonString) as Map<String, dynamic>,
);
```

When reading a data point or data series, the body is created as the Dart class of the schema identified in the header:

```dart
final dataPoint = DataPoint.fromJson(
  json.decode(jsonString) as Map<String, dynamic>,
);

if (dataPoint.body is HeartRate) {
  print((dataPoint.body as HeartRate).heartRate.value);
}
```

A body of a schema not known by this package is read as a `GenericMeasure`, which keeps the original JSON in its `json` property.

Note that only the properties defined in the schemas are read from JSON.
Other properties, which the schemas allow, are ignored.

### Checks

The Dart classes check (in debug mode) that objects comply with the schemas, where this cannot be ensured by the Dart types.
For example, a time frame must be either a point in time or a time interval, and the time frame of a physical activity or sleep measure must be a time interval.

```dart
// Fails, since a physical activity is a period of time.
PhysicalActivity(
  activityName: 'walking',
  effectiveTimeFrame: TimeFrame(dateTime: DateTime.now()),
);
```

### Adding Your Own Measures

You can define your own measures by extending `Measure`, using your own namespace in the schema id.
To read your measure as the body of a data point, register its `fromJson` function in the `MeasureFactory`:

```dart
class LightLevel extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    'example',
    'light-level',
    SchemaVersion.V1_0,
  );

  final double lux;

  LightLevel(this.lux);

  factory LightLevel.fromJson(Map<String, dynamic> json) =>
      LightLevel((json['lux'] as num).toDouble());

  @override
  Map<String, dynamic> toJson() => {'lux': lux};

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

void main() {
  MeasureFactory.register(LightLevel.SCHEMA_ID, LightLevel.fromJson);
  // ...
}
```

Measures can also be implemented using [json_serializable](https://pub.dev/packages/json_serializable), as done in this package.

## Testing

The package is tested with the sample data of the [IEEE 1752](https://opensource.ieee.org/omh/1752/-/tree/main/sample_data) repository and the test data of the [Open mHealth](https://github.com/openmhealth/schemas/tree/main/test-data) repository, which are loaded directly from these repositories.
Each sample is read into its Dart class, converted to JSON again, compared to the sample, and validated against the JSON schema.
JSON generated from measures created in Dart is validated against the JSON schemas as well.

These tests need network access to run.

## Features and Bugs

Please file feature requests and bug reports at the [issue tracker](https://github.com/carp-dk/openmhealth_schemas/issues).

## License

This software is copyright (c) the [Copenhagen Research Platform (CARP)](https://carp.dk/) at the [Technical University of Denmark (DTU)](https://www.dtu.dk).
This software is made available 'as-is' under an MIT [license](LICENSE).
