part of '../../ieee.dart';

/// This schema represents a survey as a list of at least one survey item
/// (the combination of a question and the list of provided answers).
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-1.0.json">survey</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class Survey extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.SURVEY,
    SchemaVersion.V1_0,
  );

  /// The list of questions and answers that make up this survey.
  /// Must contain at least one item.
  List<SurveyItem> items;

  /// The operational details of delivering this survey.
  SurveyDeliveryDetails deliveryDetails;

  /// The score calculated for the survey. This can be a number or a JSON
  /// object (i.e., a `Map<String, dynamic>`).
  Object? score;

  Survey({required this.items, required this.deliveryDetails, this.score})
    : assert(items.isNotEmpty, 'A survey must have at least one item.');

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// The operational details of how a [Survey] was delivered and completed.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-1.0.json">survey</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyDeliveryDetails {
  /// The date time at which this survey was started.
  DateTime? startDateTime;

  /// The date time at which this survey was finished (not necessarily completed).
  DateTime? endDateTime;

  /// The way this survey was ended by the participant. See [SurveyEndStatus].
  /// Abandoned means some answers were provided.
  /// Missed means no answers were provided.
  String? endStatus;

  SurveyDeliveryDetails({this.startDateTime, this.endDateTime, this.endStatus});

  factory SurveyDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      _$SurveyDeliveryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyDeliveryDetailsToJson(this);
}

/// The way a [Survey] was ended by the participant.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-1.0.json">survey</a>
class SurveyEndStatus {
  /// Some answers were provided.
  static const String ABANDONED = 'abandoned';

  /// The survey was completed.
  static const String COMPLETED = 'completed';

  /// No answers were provided.
  static const String MISSED = 'missed';
}

/// This schema represents a survey item, i.e., the combination of a question
/// and the list of its answers.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-item-1.0.json">survey-item</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyItem implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.SURVEY_ITEM,
    SchemaVersion.V1_0,
  );

  /// The question being asked.
  SurveyQuestion question;

  /// A list of answers to the question. This list is empty if the question
  /// isn't answered, and may have multiple elements if more than one answer
  /// is provided.
  List<SurveyAnswer> answers;

  /// The date time at which this item was presented to the participant.
  DateTime? askedDateTime;

  /// The date time at which the answer was provided. If multiple answers are
  /// provided, the suggestion is to use the last answer's date time.
  DateTime? answeredDateTime;

  /// Creates a [SurveyItem]. If no [answers] are specified, the list of
  /// answers is empty, meaning that the question was not answered.
  SurveyItem({
    required this.question,
    List<SurveyAnswer>? answers,
    this.askedDateTime,
    this.answeredDateTime,
  }) : answers = answers ?? [];

  factory SurveyItem.fromJson(Map<String, dynamic> json) =>
      _$SurveyItemFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyItemToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a survey question.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-question-1.0.json">survey-question</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyQuestion implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.SURVEY_QUESTION,
    SchemaVersion.V1_0,
  );

  /// The text of the question.
  String text;

  /// A label used to identify the question.
  String? label;

  SurveyQuestion({required this.text, this.label});

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyQuestionToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a survey answer.
///
/// The [value] can be a string, a number, a boolean, or a JSON object.
/// If the answer is chosen out of a set of categories, use
/// [SurveyCategoricalAnswer]. If the answer is a value with its unit of
/// measure, use [SurveyUnitValueAnswer]. For dates and times, use
/// [SurveyDateAnswer] and [SurveyTimeAnswer].
///
/// Note that when a [SurveyItem] is read from JSON, its answers are read as
/// [SurveyAnswer] objects, where [value] holds the raw JSON value.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-answer-1.0.json">survey-answer</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyAnswer implements SchemaSupport {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    SchemaSupport.SURVEY_ANSWER,
    SchemaVersion.V1_0,
  );

  /// The value of the answer.
  final Object value;

  SurveyAnswer({required this.value});

  factory SurveyAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyAnswerToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a categorical answer to a survey question, e.g.,
/// value `'Never'` with code `1` on a 7-point Likert scale.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-categorical-answer-1.0.json">survey-categorical-answer</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyCategoricalAnswer extends SurveyAnswer {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'survey-categorical-answer',
    SchemaVersion.V1_0,
  );

  /// A code used to identify the answer. Must be a number or a string.
  final Object? code;

  SurveyCategoricalAnswer({required super.value, this.code})
    : assert(
        code == null || code is num || code is String,
        'The code must be a number or a string.',
      );

  factory SurveyCategoricalAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyCategoricalAnswerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurveyCategoricalAnswerToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a (full or partial) date value answer to a survey
/// question. The [value] is a date formatted as `YYYY-MM-DD`, `YYYY-MM`, or
/// `YYYY`.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-date-answer-1.0.json">survey-date-answer</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyDateAnswer extends SurveyAnswer {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'survey-date-answer',
    SchemaVersion.V1_0,
  );

  static final RegExp _pattern = RegExp(
    r'^([0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{4}-[0-9]{2}|[0-9]{4})$',
  );

  SurveyDateAnswer({required String value})
    : assert(
        _pattern.hasMatch(value),
        'The date must be formatted as YYYY-MM-DD, YYYY-MM, or YYYY.',
      ),
      super(value: value);

  /// Creates a full date answer (`YYYY-MM-DD`) from [date].
  /// The time part of [date] is ignored.
  factory SurveyDateAnswer.fromDateTime(DateTime date) => SurveyDateAnswer(
    value:
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}',
  );

  /// The date as a string formatted as `YYYY-MM-DD`, `YYYY-MM`, or `YYYY`.
  @override
  String get value => super.value as String;

  factory SurveyDateAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyDateAnswerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurveyDateAnswerToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a time of day answer to a survey question.
/// The [value] is formatted as `HH:mm` in 24-hour format.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-time-answer-1.0.json">survey-time-answer</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyTimeAnswer extends SurveyAnswer {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'survey-time-answer',
    SchemaVersion.V1_0,
  );

  static final RegExp _pattern = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');

  SurveyTimeAnswer({required String value})
    : assert(
        _pattern.hasMatch(value),
        'The time must be formatted as HH:mm in 24-hour format.',
      ),
      super(value: value);

  /// The time of day as a string formatted as `HH:mm`.
  @override
  String get value => super.value as String;

  factory SurveyTimeAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyTimeAnswerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurveyTimeAnswerToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// This schema represents a unit value answer to a survey question.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/survey/survey-unit-value-answer-1.0.json">survey-unit-value-answer</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SurveyUnitValueAnswer extends SurveyAnswer {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'survey-unit-value-answer',
    SchemaVersion.V1_0,
  );

  SurveyUnitValueAnswer({required UnitValue value}) : super(value: value);

  /// The unit value.
  @override
  UnitValue get value => super.value as UnitValue;

  factory SurveyUnitValueAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyUnitValueAnswerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurveyUnitValueAnswerToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
