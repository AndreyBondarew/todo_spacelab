import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/base_connection.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/initial_db.dart';

class SQLiteDataBaseConnection implements DatabaseBaseConnection {
  static const String dbPath = 'note';
  static const int version = 1;

  final Future<Database> _db;

  SQLiteDataBaseConnection._(this._db);

  factory SQLiteDataBaseConnection() {
    Database? db;
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;
    }
    return SQLiteDataBaseConnection._(openDatabase(dbPath, onCreate: initialDb, version: version));
  }

  @override
  Future<void> transaction(TransactionExecutor action) async {
    Database db = await _db;
    await db.transaction((Transaction sqfLiteTransaction) async {
      await action(DatabaseTransactionSqlite(sqfLiteTransaction));
    });
  }
}

class DatabaseTransactionSqlite implements DatabaseBaseTransaction {
  DatabaseExecutor executor;

  DatabaseTransactionSqlite(this.executor);

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    await executor.insert(table, data);
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs}) async {
    await executor.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<List<Map<String, dynamic>>> select(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await executor.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<void> delete(String table, String id) async {
    await executor.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
