import 'dart:async';
import '../../domain/faculty/Year.dart';
import '../../resources/Texts.dart';
import '../../domain/faculty/GroupLoadOptions.dart';
import '../../domain/faculty/Group.dart';
import '../../domain/faculty/Faculty.dart';
import '../../domain/faculty/Chair.dart';
import '../../domain/faculty/IFacultyManager.dart';
import '../Constants.dart';
import '../common/AssetManager.dart';
import 'FacultyInfo.dart';
import 'provider/IFacultyProvider.dart';

typedef Future<T> RepeatableFunction<T>();

typedef Future<List<T>> EntityLoader<T>();
typedef Future EntitySaver<T>(List<T> entities);

class FacultyManager implements IFacultyManager {
  FacultyManager(this._storageProvider, this._networkProvider,
      {AssetManager assetManager}) {
    _assetManager = assetManager ?? new AssetManager(Constants.ASSET_DIRECTORY);
  }

  IFacultyProvider _storageProvider;
  IFacultyProvider _networkProvider;

  AssetManager _assetManager;

  static const int _networkRequestAttemptsCount = 3;

  @override
  Future<List<Chair>> getChairs() async {
    throw new UnimplementedError("Not implemented.");
  }

  @override
  Future<List<Year>> getYears() async {
    return (await _getEntities(() => _storageProvider.getYears(),
            () => _networkProvider.getYears(),
            toStorageSaver: (x) => _storageProvider.insertAllYears(x)))
        .map((x) => x.toYear())
        .toList();
  }

  @override
  Future<List<Faculty>> getFaculties() async {
    var faculties = await _getEntities(
        () => _storageProvider.getList(), () => _networkProvider.getList(),
        toStorageSaver: (x) => _storageProvider.insertAll(x));
    await loadFacultyImages(faculties);

    return faculties.map((x) => x.toFaculty()).toList();
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

  Future loadFacultyImages(List<FacultyInfo> faculties) async {
    assert(faculties != null);

    await for (FacultyInfo f in new Stream.fromIterable(faculties)) {
      for (String ext in Constants.SUPPORTED_IMAGE_EXTENSIONS) {
        var translatedAbbr = Texts.getText(f.abbr, "en", defaultValue: f.abbr);
        var name = "$translatedAbbr$ext";
        bool exists = await _assetManager.assetExists(name);
        if (exists) {
          f.image = name;
          break;
        }
      }
    }
  }

  @override
  Future<List<Group>> getGroups(GroupLoadOptions loadOptions) async {
    assert(loadOptions != null);

    return (await _getEntities(() => _storageProvider.getGroups(loadOptions),
            () => _networkProvider.getGroups(loadOptions),
            toStorageSaver: (x) => _storageProvider.insertAllYears(x)))
        .map((x) => x.toGroup())
        .toList();
  }

  Future<List<T>> _getEntities<T>(
      EntityLoader<T> storageLoader, EntityLoader<T> networkLoader,
      {EntitySaver<T> toStorageSaver}) async {
    var entities = await storageLoader();
    if (entities.length != 0) return entities;

    entities = await _executeWithRepeats(
            networkLoader, _networkRequestAttemptsCount) ??
        <T>[];

    if (toStorageSaver != null) {
      await toStorageSaver(entities);
    }

    return entities;
  }
}

// TODO: Unit tests, also for the providers
