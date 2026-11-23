## 1.0.0

Support for the [IEEE 1752.1](https://opensource.ieee.org/omh/1752) standard, which standardizes the core of Open mHealth.
The package now supports all IEEE 1752.1 schemas (in the `ieee` namespace), and the latest version of the Open mHealth (OMH) schemas which are not part of IEEE 1752.1 (in the `omh` namespace).

This is a major release with breaking changes, as described below.

### Added

- All IEEE 1752.1 schemas:
  - metadata: `DataPoint`, `DataSeries`, `DataPointHeader`, and `SchemaId`
  - physical activity: `PhysicalActivity`
  - sleep: `ApneaHypopneaIndex`, `ArousalIndex`, `DeepSleep`, `LightSleep`, `SleepEpisode`, `SleepOnsetLatency`, `SleepStageSummary`, `SnoreIndex`, `TimeInBed`, `TotalSleepTime`, and `WakeAfterSleepOnset`
  - environment: `AmbientLight`, `AmbientSound`, and `AmbientTemperature`
  - survey: `Survey`, `SurveyItem`, `SurveyQuestion`, and the survey answers
  - utility: unit values (e.g., `FrequencyUnitValue`, `SpeedUnitValue`, `DurationUnitValueRange`), `BodyPosture`, and more descriptive statistics.
- `MeasureFactory`: the body of a `DataPoint` or `DataSeries` is now read from JSON as the Dart class of the schema identified in the header. Measures defined outside this package can be registered. A body of an unknown schema is read as a `GenericMeasure`, which keeps the original JSON.
- Checks (in debug mode) that objects comply with the schemas, e.g., that a time frame is either a point in time or a time interval.
- Tests using the sample data of the IEEE 1752 repository and the test data of the OMH repository, including validation against the JSON schemas.

### Changed

- The package is a single library, with IEEE 1752.1 as its core. The utility schemas, such as `UnitValue`, `TimeFrame`, `TimeInterval`, and `SchemaId`, follow IEEE 1752.1.
- `DataPoint` and `DataPointHeader` follow IEEE 1752.1. The header has a `uuid`, `schemaId`, `sourceCreationDateTime`, `modality`, `acquisitionRate`, and `externalDatasheets`, and no longer a `userId` and `acquisitionProvenance`.
- The OMH schemas are updated to their latest version: `BloodPressure` 4.0, `HeartRate` 3.0, `CaloriesBurned` 3.0, `Acceleration` 2.0, `Geoposition` 2.0, `RrInterval` 2.0, and their unit values 1.1.
- `BloodPressure.positionDuringMeasurement` is replaced by `bodyPosture` (see `BodyPosture`).
- The `Acceleration` properties are renamed to `accelerationX`, `accelerationY`, `accelerationZ`, and `sensorBodyLocation`. The JSON is unchanged.
- `TimeInterval` no longer has a `date` and `partOfDay`, which are not part of IEEE 1752.1.
- Date-times are always written to JSON in UTC, and date-times without a time zone are read as UTC, as defined by IEEE 1752.1.
- `SchemaId` and `SchemaVersion` are immutable, and all `SCHEMA_ID`s and `SchemaVersion.V1_0` etc. are constants.
- `SchemaSupport.CACHET_NAMESPACE` is replaced by `CARP_NAMESPACE`.
- Requires Dart 3.8 and `json_annotation` 4.12.

### Removed

- The OMH schemas which have been deprecated in favor of IEEE 1752.1: the OMH data point and header, `PhysicalActivity`, `StepCount`, and `MinutesModerateActivity`. Use the IEEE 1752.1 `PhysicalActivity` instead, e.g., with the number of steps as `baseMovementQuantity`.
- The OMH survey schemas, which were never part of OMH and are now part of IEEE 1752.1.
- `AdditionalPropertySupport`, since additional properties were never written to JSON.
- `PositionDuringMeasurement`, which is replaced by `BodyPosture`.

### Fixed

- `PartOfDay` values are lowercase, as defined by OMH.
- `DescriptiveStatisticDenominator.DAY` is `d`, and `DurationUnit.MONTH` is `Mo`.
- The schema ids of `HeartRateUnitValue` and `RrInterUnitValue`.
- `SchemaVersion.compareTo` now orders a version with a qualifier (a pre-release) before the release.
- Reading the body of a data point, and the code of a categorical survey answer, from JSON.

## 0.3.1

- fix of error when schema version do not have a qualifier part.

## 0.3.0

- update of uuid package
- fix of linter errors

## 0.2.1+1

- updated to null-safety
- all constructors using named parameters
- small updates to docs

## 0.1.4+1

- small update to readme

## 0.1.4

- upgrade to json_serialization v. 3.0

## 0.1.3

- upgrade to json_serialization v. 2.0

## 0.1.2

- support for surveys added

## 0.1.1

- Updated documentation

## 0.1.0

- Update to support Dart 2.0

## 0.0.4

- Implemented cardio-related schemas, such as `RrInterval` and `HeartRate`.
- Improvement to documentation.

## 0.0.3

- Implementation of `BloodPressure` and associated schemas.
- Implementation of time-related schemas, such as `TemporalRelationshipToMeal` etc.
- Adding support for JSON de/serialization of the OMH schemas implemented so far.
- Extensive unit test for the de/serialization, including loading test data from the OMH website.

## 0.0.2

- Implementation of OMH schemas:
  - Activity, including `PhysicalActivity`, `KcalUnitValue`, `KcalUnit`, `StepCount`, `CalloriesBurden`, etc.
  - updates and refactor of other base schemas
- Adding more tests

## 0.0.1

- Initial commit of OMH domain model ...
  - Basic support for schemas, including `SchemaId`, `SchemaVersion`, and the mixin class `AdditionalPropertySupport`.
  - The core OMH units, including `Unit`, `UnitValue` and `TypedUnitValue`.
  - Implementation of `DescriptiveStatistic`.
  - Support for the OMH geoposition schemas including `Geoposition`, `PlaneAngleUnitValue`, etc.
- Test skeleton -- which needs to be extended to better coverage.
