part of '../../openmhealth_schemas.dart';

/// A marker interface for units of measure.
abstract class Unit extends SchemaEnumValue {
  Unit(super.schemaValue);
}

/// A numerical value with a unit of measure. This is the base class for all
/// unit value tuples.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/unit-value-1.0.json">unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UnitValue implements SchemaSupport {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'unit-value',
    SchemaVersion.V1_0,
  );

  final double value;
  final String unit;

  UnitValue(this.unit, this.value);

  factory UnitValue.fromJson(Map<String, dynamic> json) =>
      _$UnitValueFromJson(json);
  Map<String, dynamic> toJson() => _$UnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;

  @override
  String toString() => '${getSchemaId()} : {unit: $unit , value: $value}';
}

/// A length or a distance. See [LengthUnit].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/length-unit-value-1.0.json">length-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class LengthUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'length-unit-value',
    SchemaVersion.V1_0,
  );

  LengthUnitValue(super.unit, super.value);

  factory LengthUnitValue.fromJson(Map<String, dynamic> json) =>
      _$LengthUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LengthUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of length.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/length-unit-value-1.0.json">length-unit-value</a>
class LengthUnit extends Unit {
  static const String FEMTOMETER = 'fm';
  static const String PICOMETER = 'pm';
  static const String NANOMETER = 'nm';
  static const String MICROMETER = 'um';
  static const String MILLIMETER = 'mm';
  static const String CENTIMETER = 'cm';
  static const String METER = 'm';
  static const String KILOMETER = 'km';
  static const String INCH = 'in';
  static const String FOOT = 'ft';
  static const String YARD = 'yd';
  static const String MILE = 'mi';

  LengthUnit(super.schemaValue);
}

/// A duration or length of time. See [DurationUnit].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/duration-unit-value-1.0.json">duration-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DurationUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'duration-unit-value',
    SchemaVersion.V1_0,
  );

  DurationUnitValue(super.unit, super.value);

  factory DurationUnitValue.fromJson(Map<String, dynamic> json) =>
      _$DurationUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DurationUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// An amount of kilocalories. See [KcalUnit].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/kcal-unit-value-1.0.json">kcal-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class KcalUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'kcal-unit-value',
    SchemaVersion.V1_0,
  );

  KcalUnitValue({required String unit, required double value})
    : super(unit, value);

  factory KcalUnitValue.fromJson(Map<String, dynamic> json) =>
      _$KcalUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$KcalUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of kilocalories.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/kcal-unit-value-1.0.json">kcal-unit-value</a>
class KcalUnit extends Unit {
  static const String KILOCALORIE = 'kcal';

  KcalUnit(super.schemaValue);
}

/// A unit of duration.
///
/// Note that in IEEE 1752.1, the unit of month is `Mo`.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/duration-unit-value-1.0.json">duration-unit-value</a>
class DurationUnit extends Unit {
  static const String PICOSECOND = 'ps';
  static const String NANOSECOND = 'ns';
  static const String MICROSECOND = 'us';
  static const String MILLISECOND = 'ms';
  static const String SECOND = 'sec';
  static const String MINUTE = 'min';
  static const String HOUR = 'h';
  static const String DAY = 'd';
  static const String WEEK = 'wk';
  static const String MONTH = 'Mo';
  static const String YEAR = 'yr';

  DurationUnit(super.schemaValue);
}

/// A speed, i.e., a distance per unit of time.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/speed-unit-value-1.0.json">speed-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SpeedUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'speed-unit-value',
    SchemaVersion.V1_0,
  );

  SpeedUnitValue({required String unit, required double value})
    : super(unit, value);

  factory SpeedUnitValue.fromJson(Map<String, dynamic> json) =>
      _$SpeedUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SpeedUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of speed.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/speed-unit-value-1.0.json">speed-unit-value</a>
class SpeedUnit extends Unit {
  static const String METERS_PER_SECOND = 'm/s';
  static const String KILOMETERS_PER_HOUR = 'km/h';

  SpeedUnit(super.schemaValue);
}

/// A percentage.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/percent-unit-value-1.0.json">percent-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PercentUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'percent-unit-value',
    SchemaVersion.V1_0,
  );

  /// Creates a [PercentUnitValue] of [value] percent.
  PercentUnitValue({required double value, String unit = PercentUnit.PERCENT})
    : super(unit, value);

  factory PercentUnitValue.fromJson(Map<String, dynamic> json) =>
      _$PercentUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PercentUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of percentage.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/percent-unit-value-1.0.json">percent-unit-value</a>
class PercentUnit extends Unit {
  static const String PERCENT = '%';

  PercentUnit(super.schemaValue);
}

/// A sound level.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/sound-unit-value-1.0.json">sound-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SoundUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'sound-unit-value',
    SchemaVersion.V1_0,
  );

  SoundUnitValue({required String unit, required double value})
    : super(unit, value);

  factory SoundUnitValue.fromJson(Map<String, dynamic> json) =>
      _$SoundUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SoundUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of sound.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/sound-unit-value-1.0.json">sound-unit-value</a>
class SoundUnit extends Unit {
  static const String DECIBEL = 'dB';
  static const String A_WEIGHTED_DECIBEL = 'dBA';

  SoundUnit(super.schemaValue);
}

/// An illuminance, i.e., the total luminous flux incident on a surface, per
/// unit area.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/illuminance-unit-value-1.0.json">illuminance-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class IlluminanceUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'illuminance-unit-value',
    SchemaVersion.V1_0,
  );

  /// Creates an [IlluminanceUnitValue] of [value] lux.
  IlluminanceUnitValue({
    required double value,
    String unit = IlluminanceUnit.LUX,
  }) : super(unit, value);

  factory IlluminanceUnitValue.fromJson(Map<String, dynamic> json) =>
      _$IlluminanceUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$IlluminanceUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of illuminance.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/illuminance-unit-value-1.0.json">illuminance-unit-value</a>
class IlluminanceUnit extends Unit {
  static const String LUX = 'lx';

  IlluminanceUnit(super.schemaValue);
}

/// A temperature (intensity of heat).
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/temperature-unit-value-1.0.json">temperature-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TemperatureUnitValue extends UnitValue {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'temperature-unit-value',
    SchemaVersion.V1_0,
  );

  TemperatureUnitValue({required String unit, required double value})
    : super(unit, value);

  factory TemperatureUnitValue.fromJson(Map<String, dynamic> json) =>
      _$TemperatureUnitValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TemperatureUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of temperature.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/temperature-unit-value-1.0.json">temperature-unit-value</a>
class TemperatureUnit extends Unit {
  static const String KELVIN = 'K';
  static const String FAHRENHEIT = 'F';
  static const String CELSIUS = 'C';

  TemperatureUnit(super.schemaValue);
}

/// A range of numerical values with a unit of measure.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/unit-value-range-1.0.json">unit-value-range</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UnitValueRange implements SchemaSupport {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'unit-value-range',
    SchemaVersion.V1_0,
  );

  /// The lower boundary of the range.
  final double lowValue;

  /// The upper boundary of the range.
  final double highValue;

  /// The unit of measure of the range.
  final String unit;

  UnitValueRange({
    required this.lowValue,
    required this.highValue,
    required this.unit,
  });

  factory UnitValueRange.fromJson(Map<String, dynamic> json) =>
      _$UnitValueRangeFromJson(json);
  Map<String, dynamic> toJson() => _$UnitValueRangeToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;

  @override
  String toString() =>
      '${getSchemaId()} : {unit: $unit, low_value: $lowValue, high_value: $highValue}';
}

/// A range of durations, e.g., 7.6 to 8.1 hours. See [DurationUnit].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/duration-unit-value-range-1.0.json">duration-unit-value-range</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DurationUnitValueRange extends UnitValueRange {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'duration-unit-value-range',
    SchemaVersion.V1_0,
  );

  DurationUnitValueRange({
    required super.lowValue,
    required super.highValue,
    required super.unit,
  });

  factory DurationUnitValueRange.fromJson(Map<String, dynamic> json) =>
      _$DurationUnitValueRangeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DurationUnitValueRangeToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The frequency of an event, either
///
///  * in hertz, using [value] and [unit] (see [FrequencyUnitValue.hertz]), or
///  * as a number of times over a duration, using [numberOfTimes] and
///    [timeWindow] (see [FrequencyUnitValue.times]). For example, "once every
///    14 days" is 1 time in a time window of 14 days. The time window is either
///    a [DurationUnitValue] or a [DurationUnitValueRange].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/frequency-unit-value-1.0.json">frequency-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FrequencyUnitValue implements SchemaSupport {
  static const SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'frequency-unit-value',
    SchemaVersion.V1_0,
  );

  /// The frequency value, when expressed in hertz.
  final double? value;

  /// The frequency unit, when expressed in hertz. See [FrequencyUnit].
  final String? unit;

  /// How many times the event occurs in the [timeWindow].
  final double? numberOfTimes;

  /// The time window in which the event occurs [numberOfTimes].
  /// Either a [DurationUnitValue] or a [DurationUnitValueRange].
  @JsonKey(fromJson: _timeWindowFromJson)
  final Object? timeWindow;

  /// Creates a [FrequencyUnitValue]. Either [value] and [unit], or
  /// [numberOfTimes] and [timeWindow] must be specified.
  /// Consider using the [FrequencyUnitValue.hertz], [FrequencyUnitValue.times],
  /// or [FrequencyUnitValue.timesInRange] constructors instead.
  FrequencyUnitValue({
    this.value,
    this.unit,
    this.numberOfTimes,
    this.timeWindow,
  }) : assert(
         (value != null && unit != null) !=
             (numberOfTimes != null && timeWindow != null),
         'Specify either value and unit, or numberOfTimes and timeWindow.',
       ),
       assert(
         timeWindow == null ||
             timeWindow is DurationUnitValue ||
             timeWindow is DurationUnitValueRange,
         'The time window must be a DurationUnitValue or a DurationUnitValueRange.',
       );

  /// A frequency of [value] hertz.
  FrequencyUnitValue.hertz(double value)
    : this(value: value, unit: FrequencyUnit.HERTZ);

  /// A frequency of [numberOfTimes] in a [timeWindow], e.g., 2 times in 1 day.
  FrequencyUnitValue.times({
    required double numberOfTimes,
    required DurationUnitValue timeWindow,
  }) : this(numberOfTimes: numberOfTimes, timeWindow: timeWindow);

  /// A frequency of [numberOfTimes] in a [timeWindow] range, e.g., 1 time in
  /// 3 to 4 hours.
  FrequencyUnitValue.timesInRange({
    required double numberOfTimes,
    required DurationUnitValueRange timeWindow,
  }) : this(numberOfTimes: numberOfTimes, timeWindow: timeWindow);

  static Object? _timeWindowFromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    return json.containsKey('low_value')
        ? DurationUnitValueRange.fromJson(json)
        : DurationUnitValue.fromJson(json);
  }

  factory FrequencyUnitValue.fromJson(Map<String, dynamic> json) =>
      _$FrequencyUnitValueFromJson(json);
  Map<String, dynamic> toJson() => _$FrequencyUnitValueToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A unit of frequency.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/frequency-unit-value-1.0.json">frequency-unit-value</a>
class FrequencyUnit extends Unit {
  static const String HERTZ = 'Hz';

  FrequencyUnit(super.schemaValue);
}

/// The posture of the subject (for example, during a measurement).
/// This value set is not exhaustive. Values can be added as needed, preferably
/// from the Body position finding hierarchy of SNOMED CT.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/body-posture-1.0.json">body-posture</a>
class BodyPosture {
  static const String SITTING = 'sitting';
  static const String LYING_DOWN = 'lying down';
  static const String STANDING = 'standing';
  static const String SEMI_RECUMBENT = 'semi-recumbent';
}
