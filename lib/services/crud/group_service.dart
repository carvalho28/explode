import 'package:explode/models/group_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GroupService {
  static final GroupService instance = GroupService._init();

  static Database? _database;

  GroupService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('groups.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableGroups (
      ${GroupFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${GroupFields.name} TEXT NOT NULL
    )
    ''');
  }

  Future<GroupModel> createGroup(GroupModel group) async {
    final db = await instance.database;

    final id = await db.insert(tableGroups, group.toJson());
    return group.copy(id: id);
  }

  Future<GroupModel> readGroup(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGroups,
      columns: GroupFields.values,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GroupModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // get group id by name
  Future<int> getGroupId(String name) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGroups,
      columns: GroupFields.values,
      where: '${GroupFields.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return maps.first[GroupFields.id] as int;
    } else {
      // throw Exception('ID with: $name, not found');
      return -1;
    }
  }

  Future<List<GroupModel>> readAllGroups() async {
    final db = await instance.database;

    final orderBy = '${GroupFields.name} ASC';
    final result = await db.query(tableGroups, orderBy: orderBy);

    return result.map((json) => GroupModel.fromJson(json)).toList();
  }

  // read all group names
  Future<List<String>> readAllGroupNames() async {
    final db = await instance.database;

    final orderBy = '${GroupFields.name} ASC';
    final result = await db.query(tableGroups, orderBy: orderBy);

    return result.map((json) => GroupModel.fromJson(json).name).toList();
  }

  Future<int> update(GroupModel group) async {
    final db = await instance.database;

    return db.update(
      tableGroups,
      group.toJson(),
      where: '${GroupFields.id} = ?',
      whereArgs: [group.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGroups,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future deleteTable() async {
    final db = await instance.database;

    return await db.execute('DROP TABLE IF EXISTS $tableGroups');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
