import 'package:explode/models/record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RecordsDatabase {
  static final RecordsDatabase instance = RecordsDatabase._init();

  static Database? _database;

  RecordsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('records.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableRecords (
      ${RecordFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${RecordFields.correctAnswers} INTEGER NOT NULL,
      ${RecordFields.operators} TEXT NOT NULL,
      ${RecordFields.difficulty} TEXT NOT NULL,
      ${RecordFields.time} INTEGER NOT NULL
    )
    ''');
  }

  Future<RecordModel> create(RecordModel record) async {
    final db = await instance.database;

    final id = await db.insert(tableRecords, record.toJson());
    return record.copy(id: id);
  }

  Future<RecordModel> readRecord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecords,
      columns: RecordFields.values,
      where: '${RecordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RecordModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  Future<List<RecordModel>> readAllRecords() async {
    final db = await instance.database;
    final orderBy = '${RecordFields.time} ASC';
    final result = await db.query(tableRecords, orderBy: orderBy);
    return result.map((json) => RecordModel.fromJson(json)).toList();
  }

  Future<int> update(RecordModel record) async {
    final db = await instance.database;

    return db.update(
      tableRecords,
      record.toJson(),
      where: '${RecordFields.id} = ?',
      whereArgs: [record.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecords,
      where: '${RecordFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
