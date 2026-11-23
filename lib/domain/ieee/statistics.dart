part of '../../ieee.dart';

/// A descriptive statistic of a set of measurements.
///
/// IEEE 1752.1 adds a number of statistics compared to OMH, such as [COUNT],
/// percentiles, quartiles, and quintiles.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/descriptive-statistic-1.0.json">descriptive-statistic</a>
class DescriptiveStatistic {
  static const String AVERAGE = 'average';
  static const String COUNT = 'count';
  static const String MAXIMUM = 'maximum';
  static const String MEDIAN = 'median';
  static const String MINIMUM = 'minimum';
  static const String STANDARD_DEVIATION = 'standard deviation';
  static const String SUM = 'sum';
  static const String VARIANCE = 'variance';
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

/// The denominator of a descriptive statistic when the measure has an implicit
/// duration. For example, if the descriptive statistic is 'average' and the
/// denominator is [DAY], the value describes the average daily measure during
/// the period delimited by the effective time frame.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/utility/descriptive-statistic-denominator-1.0.json">descriptive-statistic-denominator</a>
class DescriptiveStatisticDenominator {
  static const String DAY = 'd';
  static const String WEEK = 'wk';
  static const String MONTH = 'Mo';
  static const String EPISODE = 'episode';
  static const String MEAL = 'meal';
  static const String SESSION = 'session';
}
