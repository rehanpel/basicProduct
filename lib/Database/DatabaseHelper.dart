import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static const _databaseName = "Cart_Offline.db";
  static const _databaseVersion = 1;

  static const table = 'user_cart';

  static const columnId = '_id';
  static const columnUserId = 'userId';
  static const columnQty = '_qty';
  static const columnDetails = 'details';
  static const columnProductId = '_pid';
  static const columnDate = '_date';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnQty INTEGER NOT NULL,
            $columnUserId TEXT NOT NULL,
            $columnDetails TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnProductId INTEGER NOT NULL
          )
          ''');

    // prepopulate a few rows (consider using a transaction)
  }
}
