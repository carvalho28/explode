final String tableRecords = 'records';

class RecordFields {
  static final List<String> values = [
    id,
    correctAnswers,
    operators,
    difficulty,
    time
  ];

  static final String id = '_id';
  static final String correctAnswers = 'correctAnswers';
  static final String operators = 'operators';
  static final String difficulty = 'difficulty';
  static final String time = 'time';
}

class RecordModel {
  final int? id;
  final int correctAnswers;
  final String difficulty;
  final String operators;
  final int time;

  const RecordModel({
    this.id,
    required this.correctAnswers,
    required this.difficulty,
    required this.operators,
    required this.time,
  });

  Map<String, Object?> toJson() => {
        RecordFields.id: id,
        RecordFields.correctAnswers: correctAnswers,
        RecordFields.difficulty: difficulty,
        RecordFields.operators: operators,
        RecordFields.time: time,
      };

  static RecordModel fromJson(Map<String, Object?> json) => RecordModel(
        id: json[RecordFields.id] as int?,
        correctAnswers: json[RecordFields.correctAnswers] as int,
        difficulty: json[RecordFields.difficulty] as String,
        operators: json[RecordFields.operators] as String,
        time: json[RecordFields.time] as int,
      );

  RecordModel copy({
    int? id,
    int? correctAnswers,
    String? difficulty,
    String? operators,
    int? time,
  }) =>
      RecordModel(
        id: id ?? this.id,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        difficulty: difficulty ?? this.difficulty,
        operators: operators ?? this.operators,
        time: time ?? this.time,
      );
}
