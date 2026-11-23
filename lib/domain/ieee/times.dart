part of '../../openmhealth_schemas.dart';

/// A time frame, which is either a point in time ([dateTime]) or a time
/// interval ([timeInterval]).
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/time-frame-1.0.json">time-frame</a>
@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  converters: [_UtcDateTimeConverter()],
)
class TimeFrame implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.TIME_FRAME,
    SchemaVersion.V1_0,
  );

  TimeInterval? timeInterval;
  DateTime? dateTime;

  /// Creates a [TimeFrame]. Specify either a [dateTime] or a [timeInterval].
  TimeFrame({this.timeInterval, this.dateTime})
    : assert(
        (timeInterval == null) != (dateTime == null),
        'Specify either a date time or a time interval.',
      );

  factory TimeFrame.fromJson(Map<String, dynamic> json) =>
      _$TimeFrameFromJson(json);
  Map<String, dynamic> toJson() => _$TimeFrameToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A time interval, specified by two of [startDateTime], [endDateTime], and
/// [duration]:
///
///  * [startDateTime] and [endDateTime],
///  * [startDateTime] and [duration], or
///  * [endDateTime] and [duration].
///
/// No commitments are made as to whether the start or end time point itself is
/// included in the interval.
///
/// Note that [duration] is not automatically calculated from the start and end
/// time.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/time-interval-1.0.json">time-interval</a>
@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  converters: [_UtcDateTimeConverter()],
)
class TimeInterval implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.TIME_INTERVAL,
    SchemaVersion.V1_0,
  );

  DateTime? startDateTime;
  DateTime? endDateTime;
  DurationUnitValue? duration;

  /// Creates a [TimeInterval] from two of [startDateTime], [endDateTime], and
  /// [duration].
  TimeInterval({this.startDateTime, this.endDateTime, this.duration})
    : assert(
        (startDateTime != null ? 1 : 0) +
                (endDateTime != null ? 1 : 0) +
                (duration != null ? 1 : 0) >=
            2,
        'Specify two of start date time, end date time, and duration.',
      );

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);
  Map<String, dynamic> toJson() => _$TimeIntervalToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
