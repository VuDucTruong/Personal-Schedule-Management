import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'local_database.dart';

class DatabaseServices {
  Database? _database;
  final dbName = 'QLCV.db';
  final dbVersion = 1;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB();
    return _database;
  }

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, dbName);
  }

  Future<Database> _initializeDB() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: dbVersion, onCreate: _onCreate, singleInstance: true);
    return database;
  }

  Future<void> _onCreate(Database database, int version) async =>
      await LocalDatabase().createTable(database);
}
