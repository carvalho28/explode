final String tablePlayers = 'players';

class PlayerFields {
  static final List<String> values = [
    id,
    name,
    groupId,
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String groupId = 'groupId';
}

class PlayerModel {
  final int? id;
  final String name;
  final int? groupId;

  const PlayerModel({
    this.id,
    required this.name,
    this.groupId,
  });

  Map<String, Object?> toJson() => {
        PlayerFields.id: id,
        PlayerFields.name: name,
        PlayerFields.groupId: groupId,
      };

  static PlayerModel fromJson(Map<String, Object?> json) => PlayerModel(
        id: json[PlayerFields.id] as int?,
        name: json[PlayerFields.name] as String,
        groupId: json[PlayerFields.groupId] as int?,
      );

  PlayerModel copy({
    int? id,
    String? name,
    int? groupId,
  }) =>
      PlayerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        groupId: groupId ?? this.groupId,
      );

  @override
  String toString() {
    return 'PlayerModel{id: $id, name: $name, groupId: $groupId}';
  }
}
