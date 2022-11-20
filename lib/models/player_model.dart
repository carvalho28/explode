final String tablePlayers = 'players';

class PlayerFields {
  static final List<String> values = [
    id,
    name,
    groupID,
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String groupID = 'groupID';
}

class PlayerModel {
  final int? id;
  final String name;
  final int? groupID;

  const PlayerModel({
    this.id,
    required this.name,
    this.groupID,
  });

  Map<String, Object?> toJson() => {
        PlayerFields.id: id,
        PlayerFields.name: name,
        PlayerFields.groupID: groupID,
      };

  static PlayerModel fromJson(Map<String, Object?> json) => PlayerModel(
        id: json[PlayerFields.id] as int?,
        name: json[PlayerFields.name] as String,
        groupID: json[PlayerFields.groupID] as int?,
      );

  PlayerModel copy({
    int? id,
    String? name,
    int? groupID,
  }) =>
      PlayerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        groupID: groupID ?? this.groupID,
      );

  @override
  String toString() {
    return 'PlayerModel{id: $id, name: $name, groupID: $groupID}';
  }
}
