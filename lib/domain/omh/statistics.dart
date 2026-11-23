part of '../../openmhealth_schemas.dart';

/// A descriptive statistic of a set of measurements.
///
/// OMH version 1.2
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_descriptive-statistic">descriptive-statistic</a>
class DescriptiveStatistic {
  static const String AVERAGE = 'average';
  static const String COUNT = 'count';
  static const String MAXIMUM = 'maximum';
  static const String MINIMUM = 'minimum';
  static const String STANDARD_DEVIATION = 'standard deviation';
  static const String VARIANCE = 'variance';
  static const String SUM = 'sum';
  static const String MEDIAN = 'median';
  static const String PERCENTILE_20TH = '20th percentile';
  static const String PERCENTILE_80TH = '80th percentile';
  static const String LOWER_QUARTILE = 'lower quartile';
  static const String UPPER_QUARTILE = 'upper quartile';
  static const String QUARTILE_DEVIATION = 'quartile deviation';
  static const String QUINTILE_1ST = '1st quintile';
  static const String QUINTILE_2ND = '2nd quintile';
  static const String QUINTILE_3RD = '3rd quintile';
  static const String QUINTILE_4TH = '4th quintile';
}

/// A denominator used by by a descriptive statistic when applied to a measure with an implicit duration.
///
/// OMH version 1.1
/// See <a href="http://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_descriptive-statistic-denominator">descriptive-statistic-denominator</a>
class DescriptiveStatisticDenominator {
  static const String DAY = 'd';
  static const String WEEK = 'wk';
  static const String MONTH = 'Mo';
  static const String EPISODE = 'episode';
  static const String MEAL = 'meal';
  static const String SESSION = 'session';
}
