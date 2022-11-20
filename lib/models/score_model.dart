final String tableScores = 'scores';

class ScoreFields {
  static final List<String> values = [
    id,
    playerId,
    groupId,
    score,
  ];

  static final String id = '_id';
  static final String playerId = 'player_id';
  static final String groupId = 'group_id';
  static final String score = 'score';
}

class ScoreModel {
  final int? id;
  final int playerId;
  final int groupId;
  final int score;

  const ScoreModel({
    this.id,
    required this.playerId,
    required this.groupId,
    required this.score,
  });

  Map<String, Object?> toJson() => {
        ScoreFields.id: id,
        ScoreFields.playerId: playerId,
        ScoreFields.groupId: groupId,
        ScoreFields.score: score,
      };

  static ScoreModel fromJson(Map<String, Object?> json) => ScoreModel(
        id: json[ScoreFields.id] as int?,
        playerId: json[ScoreFields.playerId] as int,
        groupId: json[ScoreFields.groupId] as int,
        score: json[ScoreFields.score] as int,
      );

  ScoreModel copy({
    int? id,
    int? playerId,
    int? groupId,
    int? score,
  }) =>
      ScoreModel(
        id: id ?? this.id,
        playerId: playerId ?? this.playerId,
        groupId: groupId ?? this.groupId,
        score: score ?? this.score,
      );

  @override
  String toString() {
    return 'ScoreModel{id: $id, playerId: $playerId, groupId: $groupId, score: $score}';
  }
}
