import 'dart:async';
import 'package:sqflite/sqflite.dart';

typedef Future OnCreate(Database db, int version);
typedef Future OnUpgrade(Database db, int fromVersion, int toVersion);

class DatabaseFactory {
  static final List<OnCreate> _onCreateActions = <OnCreate>[];
  static final List<OnUpgrade> _onUpgradeActions = <OnUpgrade>[];

  static void registerCreate(OnCreate action) {
    assert(action != null);

    if (_onCreateActions.contains(action))
      throw new Exception("Action was already added.");

    _onCreateActions.add(action);
  }

  static void registerUpgrade(OnUpgrade action) {
    assert(action != null);

    if (_onUpgradeActions.contains(action))
      throw new Exception("Action was already added.");

    _onUpgradeActions.add(action);
  }

  static Future _onCreate(Database db, int version) async {
    for (OnCreate action in _onCreateActions) {
      await action(db, version);
    }
  }

  static Future _onUpgrade(Database db, int fromVersion, int toVersion) async {
    for (OnUpgrade action in _onUpgradeActions) {
      await action(db, fromVersion, toVersion);
    }
  }

  static Future _onDowngrade(Database db, int fromVersion, int toVersion) {
    throw new Exception("Downgrades are not supported.");
  }

  static void configureTableDelegates() {
    registerCreate((Database db, int version) {
      if (version < 1) return;

      db.execute(""" 
        CREATE TABLE Faculties (
          id varchar(50) PRIMARY KEY,
          abbr varchar(20) NOT NULL,
          name varchar(100) NOT NULL,
          image text NULL
          )
      """);

      db.execute(""" 
        CREATE TABLE Years (
          id varchar(50) PRIMARY KEY,
          name varchar(100) NOT NULL
          )
      """);

      db.execute(""" 
        CREATE TABLE Chairs (
          id varchar(50) PRIMARY KEY,
          name varchar(100) NOT NULL
          )
      """);

      db.execute(""" 
        CREATE TABLE Groups (
          id varchar(50) PRIMARY KEY,
          name varchar(100) NOT NULL,
          yearId varchar(50) NOT NULL,
          facultyId varchar(50) NOT NULL,
          FOREIGN KEY(yearId) REFERENCES Years(id),
          FOREIGN KEY(facultyId) REFERENCES Faculties(id)
          )
      """);
    });
  }

  static Future<Database> createOrOpenDatabase(String path, int version) async {
    return await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }
}
