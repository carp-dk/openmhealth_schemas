part of '../../ieee.dart';

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
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
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

/// The frequency of an event, either
///
///  * in hertz, using [value] and [unit] (see [FrequencyUnitValue.hertz]), or
///  * as a number of times over a duration, using [numberOfTimes] and
///    [timeWindow] (see [FrequencyUnitValue.times]). For example, "once every
///    14 days" is 1 time in a time window of 14 days.
///
/// Note that IEEE 1752.1 also allows the time window to be a duration range.
/// This is not supported yet.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/frequency-unit-value-1.0.json">frequency-unit-value</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FrequencyUnitValue implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
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
  final DurationUnitValue? timeWindow;

  /// Creates a [FrequencyUnitValue]. Either [value] and [unit], or
  /// [numberOfTimes] and [timeWindow] must be specified.
  /// Consider using the [FrequencyUnitValue.hertz] or [FrequencyUnitValue.times]
  /// constructors instead.
  FrequencyUnitValue({
    this.value,
    this.unit,
    this.numberOfTimes,
    this.timeWindow,
  }) : assert(
         (value != null && unit != null) !=
             (numberOfTimes != null && timeWindow != null),
         'Specify either value and unit, or numberOfTimes and timeWindow.',
       );

  /// A frequency of [value] hertz.
  FrequencyUnitValue.hertz(double value)
    : this(value: value, unit: FrequencyUnit.HERTZ);

  /// A frequency of [numberOfTimes] in a [timeWindow].
  FrequencyUnitValue.times({
    required double numberOfTimes,
    required DurationUnitValue timeWindow,
  }) : this(numberOfTimes: numberOfTimes, timeWindow: timeWindow);

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
