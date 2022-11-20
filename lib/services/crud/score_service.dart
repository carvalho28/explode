import 'package:explode/models/group_model.dart';
import 'package:explode/models/player_model.dart';
import 'package:explode/models/score_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScoresService {
  static final ScoresService instance = ScoresService._init();

  static Database? _database;

  ScoresService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('scores.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableScores (
      ${ScoreFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ScoreFields.playerId} INTEGER NOT NULL,
      ${ScoreFields.groupId} INTEGER NOT NULL,
      ${ScoreFields.score} INTEGER NOT NULL
    )
    ''');
  }

  Future<ScoreModel> create(ScoreModel score) async {
    final db = await instance.database;

    final id = await db.insert(tableScores, score.toJson());
    return score.copy(id: id);
  }

  Future<ScoreModel> readScore(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableScores,
      columns: ScoreFields.values,
      where: '${ScoreFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ScoreModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  // given a group id, return the best score and player id
  Future<ScoreModel> getBestScore(int groupId) async {
    final db = await instance.database;

    final maps = await db.rawQuery('''
    SELECT * FROM $tableScores
    WHERE ${ScoreFields.groupId} = $groupId
    ORDER BY ${ScoreFields.score} DESC
    LIMIT 1
    ''');

    if (maps.isNotEmpty) {
      return ScoreModel.fromJson(maps.first);
    } else {
      return const ScoreModel(id: -1, playerId: -1, groupId: -1, score: -1);
    }
  }

  Future<List<ScoreModel>> readAllScores() async {
    final db = await instance.database;

    final orderBy = '${ScoreFields.score} ASC';

    final result = await db.query(tableScores, orderBy: orderBy);

    return result.map((json) => ScoreModel.fromJson(json)).toList();
  }

  Future<int> update(ScoreModel score) async {
    final db = await instance.database;

    return db.update(
      tableScores,
      score.toJson(),
      where: '${ScoreFields.id} = ?',
      whereArgs: [score.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableScores,
      where: '${ScoreFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // delete table
  Future deleteTable() async {
    final db = await instance.database;

    db.execute('DROP TABLE IF EXISTS $tableScores');
  }
}
