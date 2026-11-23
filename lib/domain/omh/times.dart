part of '../../openmhealth_schemas.dart';

/// Week days.
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_day-of-week">day-of-week</a>
class DayOfWeek extends SchemaEnumValue {
  static const String MONDAY = 'Monday';
  static const String TUESDAY = 'Tuesday';
  static const String WEDNESDAY = 'Wednesday';
  static const String THURSDAY = 'Thursday';
  static const String FRIDAY = 'Friday';
  static const String SATURDAY = 'Saturday';
  static const String SUNDAY = 'Sunday';

  DayOfWeek(super.schemaValue);
}

/// The period of time in which a day is commonly divided.
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_part-of-day">part-of-day</a>
class PartOfDay extends SchemaEnumValue {
  static const String MORNING = 'MORNING';
  static const String AFTERNOON = 'AFTERNOON';
  static const String EVENING = 'EVENING';
  static const String NIGHT = 'NIGHT';

  PartOfDay(super.schemaValue);
}

/// This schema represents the temporal relationship of a clinical measure or assessment to meals (e.g., fasting, after lunch).
///
/// OMH version 1.2
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-meal">temporal-relationship-to-meal</a>
class TemporalRelationshipToMeal extends SchemaEnumValue {
  static const String FASTING = 'fasting';
  static const String NOT_FASTING = 'not fasting';
  static const String BEFORE_MEAL = 'before meal';
  static const String AFTER_MEAL = 'after meal';
  static const String BEORE_BREAKFAST = 'before breakfast';
  static const String AFTER_BREAKFAST = 'after breakfast';
  static const String BEFORE_LUNCH = 'before lunch';
  static const String AFTER_LUNCH = 'after lunch';
  static const String BEFORE_DINNER = 'before dinner';
  static const String AFTER_DINNER = 'after dinner';
  static const String TWO_HOURS_POST_PRANDIAL = '2 hours postprandial';
  static const String WITH_MEAL = 'with meal';
  static const String WITH_FOOD = 'with food';

  TemporalRelationshipToMeal(super.schemaValue);
}

/// This schema represents the temporal relationship of a clinical measure or assessment to physical activity (e.g., at rest, during exercise).
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-physical-activity">temporal-relationship-to-physical-activity</a>
class TemporalRelationshipToPhysicalActivity extends SchemaEnumValue {
  static const String AT_REST = 'at rest';
  static const String ACTIVE = 'active';
  static const String BEFORE_EXERCISE = 'before exercise';
  static const String AFTER_EXERCISE = 'after exercise';
  static const String DURING_EXERCISE = 'during exercise';

  TemporalRelationshipToPhysicalActivity(super.schemaValue);
}

/// This schema represents the temporal relationship of a clinical measure or assessment to sleep (e.g., before sleeping, on waking).
///
/// OMH version 1.0
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_temporal-relationship-to-sleep">temporal-relationship-to-sleep</a>
class TemporalRelationshipToSleep extends SchemaEnumValue {
  static const String BEFORE_SLEEPING = 'before sleeping';
  static const String DURING_SLEEPING = 'during sleep';
  static const String ON_WAKING = 'on waking';

  TemporalRelationshipToSleep(super.schemaValue);
}
