/*import 'dart:async';
import 'dart:core';

import 'package:sqflite/sqflite.dart';

final String questionTable = 'question_table';
final String columnId = '_id';
final String columnQuestion = 'question';
final String columnGame = 'done';

class QuestionProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(
      path, 
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $questionTable (
            $columnId integer primary key autoincrement,
            $columnQuestion text not null,
            $columnGame text not null
          )
          '''
        );
      }
    );
  }

  Future<>
}*/