import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:zstu/src/core/BuildSettings.dart';

import '../../../App.dart';

class GeneralStorageProvider {
  GeneralStorageProvider(this._db) : assert(_db != null);

  Database _db;

  Future close() => _db.close();

  Future<List<Map<String, dynamic>>> executeQuery(
    String query, {
    List<dynamic> arguments,
    DatabaseExecutor executor,
  }) {
    if (BuildSettings.instance.enableLogging)
      print("SQL query: $query");
    
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
    if (BuildSettings.instance.enableLogging)
      print("SQL query in $table where $where limit $limit offset $offset");
    
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
    if (BuildSettings.instance.enableLogging)
      print("SQL query in $table with id $id");

    executor = executor ?? _db;
    var data = await executor.query(table, where: "id = ?", whereArgs: [id]);
    if (data.length > 1)
      throw new Exception("Several entities have id \"$id\"");

    return data.length == 1 ? data.first : null;
  }

  Future insertMap(String table, Map<String, dynamic> values,
      {DatabaseExecutor executor}) {
    if (BuildSettings.instance.enableLogging)
      print("SQL insert in $table with ${values.toString()}");

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
