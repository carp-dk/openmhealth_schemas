/// A Dart implementation of the [IEEE 1752.1](https://opensource.ieee.org/omh/1752)
/// Open mHealth schemas, and the [Open mHealth](https://github.com/openmhealth/schemas)
/// (OMH) schemas that have not been standardized by IEEE 1752.1.
///
/// IEEE 1752.1 standardizes the core of Open mHealth, i.e., the data point,
/// header, and utility schemas (unit values, time frames, etc.), as well as the
/// physical activity, sleep, environment, and survey schemas. These schemas
/// use the `ieee` namespace.
///
/// The OMH measures that are not part of IEEE 1752.1, such as [HeartRate] and
/// [BloodPressure], use the `omh` namespace. They are based on the IEEE 1752.1
/// utility schemas and can be used as the body of an IEEE 1752.1 [DataPoint].
///
/// The OMH schemas which have been superseded by IEEE 1752.1 (e.g., the OMH
/// data point, header, physical activity, and step count) are not supported.
library;

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

// Core
part 'domain/schemas.dart';
part 'domain/measure.dart';

// IEEE 1752.1 schemas
part 'domain/ieee/metadata.dart';
part 'domain/ieee/units.dart';
part 'domain/ieee/times.dart';
part 'domain/ieee/statistics.dart';
part 'domain/ieee/activity.dart';
part 'domain/ieee/sleep.dart';
part 'domain/ieee/environment.dart';
part 'domain/ieee/survey.dart';

// OMH schemas not (yet) part of IEEE 1752.1
part 'domain/omh/acceleration.dart';
part 'domain/omh/calories.dart';
part 'domain/omh/bloodpressure.dart';
part 'domain/omh/cardio.dart';
part 'domain/omh/geoposition.dart';
part 'domain/omh/times.dart';

part 'openmhealth_schemas.g.dart';

// auto generate json code (.g files) with:
//   dart run build_runner build --delete-conflicting-outputs
