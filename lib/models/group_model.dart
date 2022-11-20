final String tableGroups = 'groups';

class GroupFields {
  static final List<String> values = [
    id,
    name,
  ];

  static final String id = '_id';
  static final String name = 'name';
}

class GroupModel {
  final int? id;
  final String name;

  const GroupModel({
    this.id,
    required this.name,
  });

  Map<String, Object?> toJson() => {
        GroupFields.id: id,
        GroupFields.name: name,
      };

  static GroupModel fromJson(Map<String, Object?> json) => GroupModel(
        id: json[GroupFields.id] as int?,
        name: json[GroupFields.name] as String,
      );

  GroupModel copy({
    int? id,
    String? name,
  }) =>
      GroupModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  @override
  String toString() {
    return 'GroupModel{id: $id, name: $name}';
  }
}
