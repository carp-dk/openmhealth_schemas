part of '../../openmhealth_schemas.dart';

// All IEEE 1752.1 sleep measures require the effective time frame to be a
// time interval.
const String _timeIntervalRequired =
    'The effective time frame of a sleep measure must be a time interval.';

/// Units of the sleep indexes [ApneaHypopneaIndex], [ArousalIndex], and
/// [SnoreIndex].
///
/// IEEE 1752.1 version 1.0
class SleepIndexUnit extends Unit {
  /// Unit of [ApneaHypopneaIndex].
  static const String EVENTS_PER_HOUR = 'events/h';

  /// Unit of [ArousalIndex].
  static const String AWAKENINGS_PER_HOUR = 'awakenings/h';

  /// Unit of [SnoreIndex].
  static const String SNORES_PER_HOUR = 'snores/h';

  SleepIndexUnit(super.schemaValue);
}

/// A person's apnea-hypopnea index (AHI), a measure of sleep apnea severity,
/// as the average hourly number of apnea-hypopnea events during a sleep episode.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/apnea-hypopnea-index-1.0.json">apnea-hypopnea-index</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ApneaHypopneaIndex extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'apnea-hypopnea-index',
    SchemaVersion.V1_0,
  );

  /// The apnea-hypopnea index in [SleepIndexUnit.EVENTS_PER_HOUR].
  UnitValue apneaHypopneaIndex;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  ApneaHypopneaIndex({
    required this.apneaHypopneaIndex,
    required TimeFrame super.effectiveTimeFrame,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory ApneaHypopneaIndex.fromJson(Map<String, dynamic> json) =>
      _$ApneaHypopneaIndexFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ApneaHypopneaIndexToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The arousal index during a sleep episode (main or nap), i.e., the average
/// number of awakenings between 3-15 seconds per hour during a sleep episode.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/arousal-index-1.0.json">arousal-index</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ArousalIndex extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'arousal-index',
    SchemaVersion.V1_0,
  );

  /// The arousal index in [SleepIndexUnit.AWAKENINGS_PER_HOUR].
  UnitValue arousalIndex;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  ArousalIndex({
    required this.arousalIndex,
    required TimeFrame super.effectiveTimeFrame,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory ArousalIndex.fromJson(Map<String, dynamic> json) =>
      _$ArousalIndexFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ArousalIndexToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The deep sleep duration in a sleep episode (main sleep or nap), i.e., the
/// duration spent in sleep stage N3.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/deep-sleep-1.0.json">deep-sleep</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DeepSleep extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'deep-sleep',
    SchemaVersion.V1_0,
  );

  /// The duration of deep sleep.
  DurationUnitValue deepSleepDuration;

  /// The total sleep time of the sleep episode.
  DurationUnitValue totalSleepTime;

  /// The deep sleep duration as a percentage of the total sleep time.
  PercentUnitValue? deepSleepPercentage;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  DeepSleep({
    required this.deepSleepDuration,
    required this.totalSleepTime,
    required TimeFrame super.effectiveTimeFrame,
    this.deepSleepPercentage,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory DeepSleep.fromJson(Map<String, dynamic> json) =>
      _$DeepSleepFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeepSleepToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The light sleep duration in a sleep episode (main sleep or nap), i.e., the
/// duration spent in sleep stages N1 and N2.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/light-sleep-1.0.json">light-sleep</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class LightSleep extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'light-sleep',
    SchemaVersion.V1_0,
  );

  /// The duration of light sleep.
  DurationUnitValue lightSleepDuration;

  /// The total sleep time of the sleep episode.
  DurationUnitValue totalSleepTime;

  /// The light sleep duration as a percentage of the total sleep time.
  PercentUnitValue? lightSleepPercentage;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  LightSleep({
    required this.lightSleepDuration,
    required this.totalSleepTime,
    required TimeFrame super.effectiveTimeFrame,
    this.lightSleepPercentage,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory LightSleep.fromJson(Map<String, dynamic> json) =>
      _$LightSleepFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LightSleepToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// One sleep episode.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-episode-1.0.json">sleep-episode</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SleepEpisode extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'sleep-episode',
    SchemaVersion.V1_0,
  );

  /// The time between going to bed with the intention to sleep and sleep onset.
  DurationUnitValue? latencyToSleepOnset;

  /// The time between the final awakening and getting out of bed.
  DurationUnitValue? latencyToArising;

  /// The total sleep time, i.e., the duration after sleep onset minus the
  /// duration of all awakenings.
  DurationUnitValue? totalSleepTime;

  /// The duration of light sleep (stages N1 and N2).
  DurationUnitValue? lightSleepDuration;

  /// The duration of deep sleep (stage N3).
  DurationUnitValue? deepSleepDuration;

  /// The duration of REM sleep.
  DurationUnitValue? remSleepDuration;

  /// The summed duration of all awakenings after sleep onset.
  DurationUnitValue? wakeAfterSleepOnset;

  /// The number of awakenings during the sleep episode.
  int? numberOfAwakenings;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// The total sleep time as a percentage of the time in bed.
  PercentUnitValue? sleepEfficiencyPercentage;

  SleepEpisode({
    required TimeFrame super.effectiveTimeFrame,
    this.latencyToSleepOnset,
    this.latencyToArising,
    this.totalSleepTime,
    this.lightSleepDuration,
    this.deepSleepDuration,
    this.remSleepDuration,
    this.wakeAfterSleepOnset,
    this.numberOfAwakenings,
    this.isMainSleep,
    this.sleepEfficiencyPercentage,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory SleepEpisode.fromJson(Map<String, dynamic> json) =>
      _$SleepEpisodeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SleepEpisodeToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// Sleep onset latency, i.e., the amount of time between when a person starts
/// to want to go to sleep and sleep onset.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-onset-latency-1.0.json">sleep-onset-latency</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SleepOnsetLatency extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'sleep-onset-latency',
    SchemaVersion.V1_0,
  );

  /// The sleep onset latency.
  DurationUnitValue sleepOnsetLatency;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  SleepOnsetLatency({
    required this.sleepOnsetLatency,
    required TimeFrame super.effectiveTimeFrame,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory SleepOnsetLatency.fromJson(Map<String, dynamic> json) =>
      _$SleepOnsetLatencyFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SleepOnsetLatencyToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The varying sleep stages and wakefulness within an entire sleep episode,
/// as a [sleepStageSummary] and an optional list of [sleepStageEpisodes].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-stage-summary-1.0.json">sleep-stage-summary</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SleepStageSummary extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'sleep-stage-summary',
    SchemaVersion.V1_0,
  );

  /// The summary of the sleep stages.
  SleepStageSummaryDetails sleepStageSummary;

  /// The individual sleep stage episodes.
  List<SleepStageEpisode>? sleepStageEpisodes;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  SleepStageSummary({
    required this.sleepStageSummary,
    required TimeFrame super.effectiveTimeFrame,
    this.sleepStageEpisodes,
    this.isMainSleep,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory SleepStageSummary.fromJson(Map<String, dynamic> json) =>
      _$SleepStageSummaryFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SleepStageSummaryToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The summary of sleep stages in a [SleepStageSummary].
/// Only the [totalSleepTime] is required.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-stage-summary-1.0.json">sleep-stage-summary</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SleepStageSummaryDetails {
  DurationUnitValue totalSleepTime;
  PercentUnitValue? sleepEfficiencyPercentage;
  DurationUnitValue? latencyToSleepOnset;
  DurationUnitValue? latencyToArising;
  DurationUnitValue? remSleepDuration;
  int? remSleepEpisodeCount;
  PercentUnitValue? remSleepPercentage;
  DurationUnitValue? lightSleepDuration;
  int? lightSleepEpisodeCount;
  PercentUnitValue? lightSleepPercentage;
  DurationUnitValue? deepSleepDuration;
  int? deepSleepEpisodeCount;
  PercentUnitValue? deepSleepPercentage;
  DurationUnitValue? awakeDuration;
  int? numberOfAwakenings;
  PercentUnitValue? awakePercentage;

  /// See [DescriptiveStatistic].
  String? descriptiveStatistic;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  SleepStageSummaryDetails({
    required this.totalSleepTime,
    this.sleepEfficiencyPercentage,
    this.latencyToSleepOnset,
    this.latencyToArising,
    this.remSleepDuration,
    this.remSleepEpisodeCount,
    this.remSleepPercentage,
    this.lightSleepDuration,
    this.lightSleepEpisodeCount,
    this.lightSleepPercentage,
    this.deepSleepDuration,
    this.deepSleepEpisodeCount,
    this.deepSleepPercentage,
    this.awakeDuration,
    this.numberOfAwakenings,
    this.awakePercentage,
    this.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  });

  factory SleepStageSummaryDetails.fromJson(Map<String, dynamic> json) =>
      _$SleepStageSummaryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SleepStageSummaryDetailsToJson(this);
}

/// A single episode of a sleep stage in a [SleepStageSummary].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-stage-summary-1.0.json">sleep-stage-summary</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SleepStageEpisode {
  /// The sleep stage. See [SleepStageState].
  String sleepStageState;

  /// The time frame of this sleep stage. Must be a time interval.
  TimeFrame sleepStageTimeFrame;

  SleepStageEpisode({
    required this.sleepStageState,
    required this.sleepStageTimeFrame,
  }) : assert(
         sleepStageTimeFrame.timeInterval != null,
         'The time frame of a sleep stage must be a time interval.',
       );

  factory SleepStageEpisode.fromJson(Map<String, dynamic> json) =>
      _$SleepStageEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$SleepStageEpisodeToJson(this);
}

/// The state of a [SleepStageEpisode].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/sleep-stage-summary-1.0.json">sleep-stage-summary</a>
class SleepStageState {
  static const String REM = 'REM_sleep';
  static const String LIGHT = 'Light_sleep';
  static const String DEEP = 'Deep_sleep';
  static const String UNKNOWN = 'Unknown_sleep';
  static const String AWAKE = 'Awake';
}

/// The snore index in a sleep episode (main sleep or nap), i.e., the average
/// number of snores per hour during a sleep episode.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/snore-index-1.0.json">snore-index</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SnoreIndex extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'snore-index',
    SchemaVersion.V1_0,
  );

  /// The snore index in [SleepIndexUnit.SNORES_PER_HOUR].
  UnitValue snoreIndex;

  /// The individual snore events.
  List<SnoreEvent>? snoreEvents;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  SnoreIndex({
    required this.snoreIndex,
    required TimeFrame super.effectiveTimeFrame,
    this.snoreEvents,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory SnoreIndex.fromJson(Map<String, dynamic> json) =>
      _$SnoreIndexFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SnoreIndexToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A single snore event in a [SnoreIndex].
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/snore-index-1.0.json">snore-index</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SnoreEvent {
  /// Whether the person snored.
  bool snored;

  /// The time interval of this snore event.
  TimeInterval snoreTimeFrame;

  /// The intensity of the snore.
  SoundUnitValue? snoreIntensity;

  /// The body posture during the snore event. See [BodyPosture].
  String? bodyPosture;

  SnoreEvent({
    required this.snored,
    required this.snoreTimeFrame,
    this.snoreIntensity,
    this.bodyPosture,
  });

  factory SnoreEvent.fromJson(Map<String, dynamic> json) =>
      _$SnoreEventFromJson(json);
  Map<String, dynamic> toJson() => _$SnoreEventToJson(this);
}

/// Time in bed, i.e., an interval derived from the time the person went to
/// bed and the time they got up out of bed.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/time-in-bed-1.0.json">time-in-bed</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TimeInBed extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'time-in-bed',
    SchemaVersion.V1_0,
  );

  /// The time in bed.
  DurationUnitValue timeInBed;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  TimeInBed({
    required this.timeInBed,
    required TimeFrame super.effectiveTimeFrame,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory TimeInBed.fromJson(Map<String, dynamic> json) =>
      _$TimeInBedFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TimeInBedToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// Total sleep time (TST), i.e., the duration after sleep onset in an entire
/// sleep episode minus the duration of all awakenings.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/total-sleep-time-1.0.json">total-sleep-time</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TotalSleepTime extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'total-sleep-time',
    SchemaVersion.V1_0,
  );

  /// The total sleep time.
  DurationUnitValue totalSleepTime;

  /// The time intervals during which the person was asleep.
  List<TimeInterval>? sleepEvents;

  /// Whether this is the main sleep episode (as opposed to a nap).
  bool? isMainSleep;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  TotalSleepTime({
    required this.totalSleepTime,
    required TimeFrame super.effectiveTimeFrame,
    this.sleepEvents,
    this.isMainSleep,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory TotalSleepTime.fromJson(Map<String, dynamic> json) =>
      _$TotalSleepTimeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TotalSleepTimeToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// Wake after sleep onset (WASO), i.e., the summed duration of all awakenings
/// (minimum 15 seconds) after sleep onset in a main sleep episode.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/sleep/wake-after-sleep-onset-1.0.json">wake-after-sleep-onset</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class WakeAfterSleepOnset extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'wake-after-sleep-onset',
    SchemaVersion.V1_0,
  );

  /// The summed duration of all awakenings.
  DurationUnitValue wakeAfterSleepOnset;

  /// The durations of the individual awakenings.
  List<DurationUnitValue>? awakeningDurations;

  /// See [DescriptiveStatisticDenominator].
  String? descriptiveStatisticDenominator;

  WakeAfterSleepOnset({
    required this.wakeAfterSleepOnset,
    required TimeFrame super.effectiveTimeFrame,
    this.awakeningDurations,
    super.descriptiveStatistic,
    this.descriptiveStatisticDenominator,
  }) : assert(effectiveTimeFrame.timeInterval != null, _timeIntervalRequired);

  factory WakeAfterSleepOnset.fromJson(Map<String, dynamic> json) =>
      _$WakeAfterSleepOnsetFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WakeAfterSleepOnsetToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
