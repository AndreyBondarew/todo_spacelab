import 'dart:async';

import 'package:sqflite/sqflite.dart';

FutureOr<void> initialDb(Database db, int version) async {
  Batch batch = db.batch();
  batch.execute('''
    CREATE TABLE notes(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NULL,
        is_done BOOLEAN NOT NULL DEFAULT 0
    );
    ''');
  batch.commit();
}
