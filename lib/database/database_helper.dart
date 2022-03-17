import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DataBaseHelperClass {
  static final _dbName = "my_database.db";
  static final _dbVersion = 1;
  static final _tableName = "TODO";

  static final columnID = "_id";
  static final columnTitle = "Title";
  static final columnDate = "Date";
  static final columnCreatedOn = "CreatedOn";
  static final columnNote = "Note";

  DataBaseHelperClass._privateConstructor();
  static final DataBaseHelperClass instance =
      DataBaseHelperClass._privateConstructor();

  static Database? _database;
  Future get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_tableName(
      $columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $columnTitle TEXT NOT NULL,

      $columnCreatedOn TEXT NOT NULL,
   
      $columnNote TEXT NOT NULL )
      ''');
  }
  // $columnDate TEXT NOT NULL,


  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    print("mera database $db");
    print("heloo$row");

    return await db.insert(_tableName, row);
  }

  Future<void> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    db.update(_tableName, row, where: '$columnID=?', whereArgs: [id]);
  }

  Future<List<Map<String,dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }
}
