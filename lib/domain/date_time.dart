part of '../openmhealth_schemas.dart';

/// Converts date-times to and from JSON as defined by IEEE 1752.1, i.e., as
/// an RFC 3339 / ISO 8601 date-time where a missing time zone means UTC.
///
/// * Date-times are always written in UTC (e.g., `2026-11-23T07:00:00.000Z`).
///   Dart writes a local [DateTime] without a time zone offset, which other
///   systems would read as UTC, i.e., as a different point in time.
/// * Date-times without a time zone offset are read as UTC. Dart would read
///   them as local time.
///
/// Date-times are hence always the same point in time in Dart and in JSON.
class _UtcDateTimeConverter implements JsonConverter<DateTime, String> {
  const _UtcDateTimeConverter();

  static final RegExp _timeZone = RegExp(r'(Z|[+-]\d{2}(:?\d{2})?)$', caseSensitive: false);

  @override
  DateTime fromJson(String json) => DateTime.parse(
    json.contains('T') && !_timeZone.hasMatch(json) ? '${json}Z' : json,
  );

  @override
  String toJson(DateTime dateTime) => dateTime.toUtc().toIso8601String();
}
