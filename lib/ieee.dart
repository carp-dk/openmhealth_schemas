/// A Dart implementation of the [IEEE 1752.1](https://opensource.ieee.org/omh/1752)
/// Open mHealth schemas.
///
/// IEEE 1752.1 standardizes a subset of the original Open mHealth (OMH) schemas.
/// This library contains the schemas that have been standardized, using the
/// `ieee` namespace. Schemas that are unchanged between OMH and IEEE 1752.1
/// (e.g., [UnitValue], [TimeFrame], and [SchemaId]) are re-exported from the
/// `openmhealth_schemas` library.
///
/// The original OMH schemas are still available in the `openmhealth_schemas`
/// library. Since the two libraries share class names (e.g., [DataPoint] and
/// [PhysicalActivity]), use an import prefix if both are needed:
///
/// ```dart
/// import 'package:openmhealth_schemas/openmhealth_schemas.dart';
/// import 'package:openmhealth_schemas/ieee.dart' as ieee;
/// ```
library;

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'openmhealth_schemas.dart'
    hide
        DataPoint,
        DataPointHeader,
        DataPointAcquisitionProvenance,
        PhysicalActivity,
        DescriptiveStatistic,
        DescriptiveStatisticDenominator,
        DurationUnit,
        Survey,
        SurveyItem,
        SurveyQuestion,
        AbstractSurveyAnswer,
        SurveyAnswer,
        SurveyCategoricalAnswer,
        SurveyDateAnswer,
        SurveyTimeAnswer,
        SurveyUnitValueAnswer,
        SurveyDeliveryDetails,
        SurveyScore;

// Schemas which are identical in OMH and IEEE 1752.1.
export 'openmhealth_schemas.dart'
    show
        SchemaSupport,
        SchemaEnumValue,
        SchemaId,
        SchemaVersion,
        Measure,
        AdditionalPropertySupport,
        DataPointModality,
        TimeFrame,
        TimeInterval,
        Unit,
        UnitValue,
        LengthUnit,
        LengthUnitValue,
        DurationUnitValue,
        KcalUnit,
        KcalUnitValue,
        SelfReportedIntensity,
        SurveyEndStatus;

part 'domain/ieee/metadata.dart';
part 'domain/ieee/activity.dart';
part 'domain/ieee/survey.dart';
part 'domain/ieee/units.dart';
part 'domain/ieee/statistics.dart';

part 'ieee.g.dart';

// auto generate json code (.g files) with:
//   dart run build_runner build --delete-conflicting-outputs
