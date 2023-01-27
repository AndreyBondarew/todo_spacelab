abstract class DatabaseBaseConnection {
  Future<void> transaction(TransactionExecutor action);
}

abstract class DatabaseBaseTransaction {
  Future<void> insert(String table, Map<String, dynamic> data);

  Future<void> update(String table, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs});

  Future<void> delete(String table, String id);

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
  });
}

typedef Future<void> TransactionExecutor(DatabaseBaseTransaction transaction);
