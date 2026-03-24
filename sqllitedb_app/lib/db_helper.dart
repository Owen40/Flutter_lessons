import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('people.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE people(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      age INTEGER
    )
    ''');
  }

  Future insertPerson(Map<String, dynamic> person) async {
    final db = await instance.database;
    return await db.insert('people', person);
  }

  Future<List<Map<String, dynamic>>> getPeople() async {
    final db = await instance.database;
    return await db.query('people');
  }
}
