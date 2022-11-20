import 'package:explode/models/group_model.dart';
import 'package:explode/models/player_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlayersService {
  static final PlayersService instance = PlayersService._init();

  static Database? _database;

  PlayersService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('players.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tablePlayers (
      ${PlayerFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PlayerFields.name} TEXT NOT NULL,
      ${PlayerFields.groupId} INTEGER NOT NULL REFERENCES $tableGroups(${GroupFields.id})
    )
    ''');
  }

  Future<PlayerModel> create(PlayerModel player) async {
    final db = await instance.database;

    final id = await db.insert(tablePlayers, player.toJson());
    return player.copy(id: id);
  }

  // read all players with a group id
  Future<List<PlayerModel>> readPlayers(int groupId) async {
    final db = await instance.database;

    final orderBy = '${PlayerFields.name} ASC';

    final result = await db.query(tablePlayers,
        columns: PlayerFields.values,
        where: '${PlayerFields.groupId} = ?',
        whereArgs: [groupId],
        orderBy: orderBy);

    return result.map((json) => PlayerModel.fromJson(json)).toList();
  }

  // ready players name with a group id
  Future<List<String>> readPlayersName(int groupId) async {
    final db = await instance.database;

    final orderBy = '${PlayerFields.name} ASC';

    final result = await db.query(tablePlayers,
        columns: [PlayerFields.name],
        where: '${PlayerFields.groupId} = ?',
        whereArgs: [groupId],
        orderBy: orderBy);

    return result.map((json) => PlayerModel.fromJson(json).name).toList();
  }

  // get player id with a player name
  Future<int?> getPlayerId(String playerName) async {
    final db = await instance.database;

    final result = await db.query(tablePlayers,
        columns: [PlayerFields.id],
        where: '${PlayerFields.name} = ?',
        whereArgs: [playerName]);

    return result.map((json) => PlayerModel.fromJson(json).id).toList()[0];
  }

  // read all elements in the table
  Future<List<PlayerModel>> readAllPlayers() async {
    final db = await instance.database;

    final orderBy = '${PlayerFields.name} ASC';

    final result = await db.query(tablePlayers, orderBy: orderBy);

    return result.map((json) => PlayerModel.fromJson(json)).toList();
  }

  Future<int> update(PlayerModel player) async {
    final db = await instance.database;

    return db.update(tablePlayers, player.toJson(),
        where: '${PlayerFields.id} = ?', whereArgs: [player.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tablePlayers, where: '${PlayerFields.id} = ?', whereArgs: [id]);
  }

  // delete table
  Future deleteTable() async {
    final db = await instance.database;

    return await db.execute('DROP TABLE IF EXISTS $tablePlayers');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
