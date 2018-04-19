import 'dart:async';
import 'package:sqflite/sqflite.dart';

class GeneralStorageProvider {
  GeneralStorageProvider(this._db) : assert(_db != null);

  Database _db;

  Future close() async => _db.close();

  Future<List<Map<String, dynamic>>> executeQuery(
    String query, {
    List<dynamic> arguments,
    DatabaseExecutor executor,
  }) {
    executor = executor ?? _db;
    return executor.rawQuery(query, arguments);
  }

  Future<List<Map<String, dynamic>>> getMapList(
    String table, {
    bool distinct,
    List<String> columns,
    String where,
    List whereArgs,
    String groupBy,
    String having,
    String orderBy,
    int limit,
    int offset,
    DatabaseExecutor executor,
  }) {
    executor = executor ?? _db;
    return executor.query(
      table,
      columns: columns,
      distinct: distinct,
      groupBy: groupBy,
      having: having,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<Map<String, dynamic>> getEntityMap(String table, String id,
      {DatabaseExecutor executor}) async {
    executor = executor ?? _db;
    var data = await executor.query(table, where: "id = ?", whereArgs: [id]);
    if (data.length > 1)
      throw new Exception("Several entities have id \"$id\"");

    return data.length == 1 ? data.first : null;
  }

  Future insertMap(String table, Map<String, dynamic> values,
      {DatabaseExecutor executor}) {
    executor = executor ?? _db;
    return executor.insert(table, values,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  void batchInsertMap(String table, Batch batch, Map<String, dynamic> values) {
    batch.insert(table, values, conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future deleteMap(String table, String id,
      {String where, List whereArgs, DatabaseExecutor executor}) {
    executor = executor ?? _db;
    return executor.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<Transaction> transaction(Future<Transaction> action(Transaction t),
      {bool exclusive}) {
    return _db.transaction(action, exclusive: exclusive);
  }

  Batch batch() {
    return _db.batch();
  }
}
