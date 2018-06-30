import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zstu/src/core/locale/ILocaleProvider.dart';
import 'dart:async';
import 'dart:io';
import '../domain/common/IAssetManager.dart';
import '../domain/common/text/ITextProcessor.dart';
import '../domain/faculty/Faculty.dart';
import '../domain/faculty/IFacultyManager.dart';
import '../domain/faculty/IFacultyProvider.dart';
import '../domain/schedule/IScheduleManager.dart';
import '../domain/schedule/IScheduleProvider.dart';
import 'Constants.dart';
import 'common/AssetManager.dart';
import 'common/DatabaseFactory.dart';
import 'common/TextProcessor.dart';
import 'common/provider/GeneralNetworkProvider.dart';
import 'common/provider/GeneralStorageProvider.dart';
import 'faculty/FacultyManager.dart';
import 'faculty/provider/FacultyApiProvider.dart';
import 'faculty/provider/FacultyStorageProvider.dart';
import 'schedule/ScheduleManager.dart';
import 'schedule/provider/ScheduleApiProvider.dart';
import 'schedule/provider/ScheduleStorageProvider.dart';

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

  static IFacultyProvider _provideFacultyStorage() {
    return new FacultyStorageProvider(_provideLocalStorage());
  }

  static IFacultyProvider _provideFacultyNetwork() {
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

  static IScheduleProvider _provideScheduleStorage() {
    return new ScheduleStorageProvider(_provideLocalStorage());
  }

  static IScheduleProvider _provideScheduleNetwork() {
    return new ScheduleApiProvider(_provideNetworkStorage());
  }

  static IScheduleManager _scheduleManager;
  static IScheduleManager provideSchedule() {
    if (!configured)
      throw new StateError(
          "Database was not configured. Please, call the configure() first.");

    return _scheduleManager = _scheduleManager ??
        new ScheduleManager(
            _provideScheduleStorage(), _provideScheduleNetwork());
  }

  static ITextProcessor _textProcessor;
  static ITextProcessor provideTextProcessor(ILocaleProvider localeProvider) {
    return _textProcessor = _textProcessor ?? new TextProcessor(localeProvider);
  }

  static bool configured = false;
  static Future configure() async {
    DatabaseFactory.configureTableDelegates();
    await _initDatabase();
    configured = true;
  }
}
