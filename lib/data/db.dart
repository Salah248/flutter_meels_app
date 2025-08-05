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
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, title TEXT, rate TEXT, time TEXT)',
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

  static Future<List<Map<String, dynamic>>> query(CardModel card) async {
    debugPrint('queried data');
    return await _db!.query(_tableName);
  }
}
