import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import '../domain/common/IAssetManager.dart';
import '../domain/faculty/Faculty.dart';
import '../domain/faculty/IFacultyManager.dart';
import 'Constants.dart';
import 'common/AssetManager.dart';
import 'common/DatabaseFactory.dart';
import 'common/provider/GeneralNetworkProvider.dart';
import 'common/provider/GeneralStorageProvider.dart';
import 'common/provider/IProvider.dart';
import 'faculty/FacultyManager.dart';
import 'faculty/provider/FacultyApiProvider.dart';
import 'faculty/provider/FacultyStorageProvider.dart';

class DataModule {
  static Database _database;
  static Future _initDatabase() async {
    Directory storageDir = await getApplicationDocumentsDirectory();
    _database = await DatabaseFactory.createOrOpenDatabase(
        join(storageDir.path, Constants.DB_NAME), Constants.DB_VERSION);
  }

  static GeneralStorageProvider _generalStorage;
  static GeneralStorageProvider _provideLocalStorage() {
    if (_generalStorage != null) return _generalStorage;

    return _generalStorage = new GeneralStorageProvider(_database);
  }

  static GeneralNetworkProvider _generalNetworkStorage;
  static GeneralNetworkProvider _provideNetworkStorage() {
    return _generalNetworkStorage ??
        (_generalNetworkStorage = new GeneralNetworkProvider());
  }

  static IProvider<Faculty> _provideFacultyStorage() {
    return new FacultyStorageProvider(_provideLocalStorage());
  }

  static IProvider<Faculty> _provideFacultyNetwork() {
    return new FacultyApiProvider(_provideNetworkStorage());
  }

  static IFacultyManager _facultyManager;
  static IFacultyManager provideFaculty() {
    if (!configured)
      throw new StateError(
          "Database was not configured. Please, call the configure() first.");

    return _facultyManager ??
        (_facultyManager = new FacultyManager(
            _provideFacultyStorage(), _provideFacultyNetwork()));
  }

  static IAssetManager _assetManager;
  static IAssetManager provideAsset() {
    if (!configured)
      throw new StateError(
          "Database was not configured. Please, call the configure() first.");

    return _assetManager ??
        (_assetManager = new AssetManager(Constants.ASSET_DIRECTORY));
  }

  static bool configured = false;
  static Future configure() async {
    DatabaseFactory.configureTableDelegates();
    await _initDatabase();
    configured = true;
  }
}
