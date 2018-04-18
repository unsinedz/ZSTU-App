import 'dart:async';
import '../../domain/common/IAssetManager.dart';
import '../../domain/faculty/ChairLoadOptions.dart';
import '../../domain/faculty/IFacultyProvider.dart';
import '../../domain/faculty/Year.dart';
import '../../resources/Texts.dart';
import '../Constants.dart';
import '../common/AssetManager.dart';
import '../../domain/faculty/GroupLoadOptions.dart';
import '../../domain/faculty/Group.dart';
import '../../domain/faculty/Faculty.dart';
import '../../domain/faculty/Chair.dart';
import '../../domain/faculty/IFacultyManager.dart';

typedef Future<T> RepeatableFunction<T>();
typedef Future EntitySaver<T>(T entity);

class FacultyManager implements IFacultyManager {
  FacultyManager(this._storageProvider, this._networkProvider,
      {AssetManager assetManager}) {
    _assetManager = assetManager ?? new AssetManager(Constants.ASSET_DIRECTORY);
  }

  IFacultyProvider _storageProvider;
  IFacultyProvider _networkProvider;

  IAssetManager _assetManager;

  static const int _networkRequestAttemptsCount = 3;

  @override
  Future<List<Chair>> getChairs(ChairLoadOptions loadOptions) async {
    return _getAndCacheEntities(
      () => _storageProvider.getChairs(loadOptions),
      () => _networkProvider.getChairs(loadOptions),
      saveToStorage: _storageProvider.insertAllChairs,
    );
  }

  @override
  Future<List<Year>> getYears() async {
    return await _getAndCacheEntities(
      () => _storageProvider.getYears(),
      () => _networkProvider.getYears(),
      saveToStorage: _storageProvider.insertAllYears,
    );
  }

  @override
  Future<List<Faculty>> getFaculties() async {
    var faculties = await _getAndCacheEntities(
      () => _storageProvider.getList(),
      () => _networkProvider.getList(),
      saveToStorage: _storageProvider.insertAll,
    );
    await loadFacultyImages(faculties);

    return faculties;
  }

  @override
  Future<List<Group>> getGroups(GroupLoadOptions loadOptions) async {
    return await _getAndCacheEntities(
      () => _storageProvider.getGroups(loadOptions),
      () => _networkProvider.getGroups(loadOptions),
      saveToStorage: _storageProvider.insertAllGroups,
    );
  }

  Future<List<T>> _getAndCacheEntities<T>(
    RepeatableFunction<List<T>> fetchFromStorage,
    RepeatableFunction<List<T>> fetchFromNetwork, {
    EntitySaver<List<T>> saveToStorage,
  }) async {
    assert(fetchFromStorage != null);
    assert(fetchFromNetwork != null);

    var entities = await fetchFromStorage();
    if (entities.length == 0) {
      entities = await _executeWithRepeats(
              fetchFromNetwork, _networkRequestAttemptsCount) ??
          <T>[];

      if (saveToStorage != null) await saveToStorage(entities);
    }

    return entities;
  }

  Future<T> _executeWithRepeats<T>(
      RepeatableFunction operation, int repeatCount) async {
    assert(operation != null);
    assert(repeatCount > 0);

    T result;
    while (repeatCount-- > 0) {
      try {
        result = await operation();
        break;
      } catch (e) {}
    }

    return result;
  }

  Future loadFacultyImages(List<Faculty> faculties) async {
    assert(faculties != null);

    await for (Faculty f in new Stream.fromIterable(faculties)) {
      for (String ext in Constants.SUPPORTED_IMAGE_EXTENSIONS) {
        var translatedAbbr = Texts.getText(f.abbr, "en", f.abbr);
        var name = "$translatedAbbr$ext";
        bool exists = await _assetManager.assetExists(name);
        if (exists) {
          f.image = name;
          break;
        }
      }
    }
  }
}
