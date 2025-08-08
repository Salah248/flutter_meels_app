import 'package:flutter/material.dart';
import 'package:flutter_meels_app/data/model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'card';
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null');
      return;
    } else {
      try {
        final String path = '${await getDatabasesPath()}/$_tableName.dbF';
        debugPrint('path: $path');
        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            debugPrint('data base created');
            await db.execute(
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, title TEXT, description TEXT, rate REAL, time TEXT)',
            );
          },
        );
      } catch (e) {
        debugPrint('error: $e');
      }
    }
  }

  static Future<int> insert(CardModel card) async {
    debugPrint('inserted');
    return await _db!.insert(_tableName, card.toMap());
  }

  static Future<List<CardModel>> query() async {
    debugPrint('queried data');
    final List<Map<String, dynamic>> data = await _db!.query(_tableName);
    return data.map((item) => CardModel.fromMap(item)).toList();
  }

  static Future<int> deleteAll() async {
    debugPrint('deleted all data');
    return await _db!.delete(_tableName);
  }

  static Future<void> deleteOldDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/card.dbF';
    await deleteDatabase(path);
    debugPrint('Old database deleted');
  }
}
