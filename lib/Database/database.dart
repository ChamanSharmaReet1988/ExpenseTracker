import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() {
    return _instance;
  }
  DatabaseHelper._internal();

  static Future<void> open() async {
    _database = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expensetracker.db');
    if (kDebugMode) {
      print('DB Path: $path');
    }
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  static Future<void> onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ExpenseTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT, amount TEXT, desc Text, category Text)',
    );
    await db.execute(
      'CREATE TABLE BudgetTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT, amount TEXT)',
    );
  }

  static Future<void> onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create new table in version 2
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
