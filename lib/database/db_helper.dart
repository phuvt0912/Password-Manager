import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  //Getter of _database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('accounts.db');
    return _database!;
  }
  //Just a function to initialize database if not existed
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        accountType TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // CREATE and return the id of the inserted row
  Future<int> insertAccount(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('accounts', row);
  }

  // READ all accounts
  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await instance.database;
    return await db.query('accounts');
  }

  // UPDATE an account, return the number of rows affected
  Future<int> updateAccount(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];

    return await db.update(
      'accounts',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE an account, return the number of rows affected
  Future<int> deleteAccount(int id) async {
    final db = await instance.database;

    return await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}