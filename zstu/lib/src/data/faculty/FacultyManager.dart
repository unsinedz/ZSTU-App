import 'dart:async';
import '../../resources/Texts.dart';
import '../Constants.dart';
import '../common/AssetManager.dart';
import '../common/provider/IProvider.dart';
import 'FacultyInfo.dart';
import '../../domain/faculty/GroupLoadOptions.dart';
import '../../domain/faculty/Group.dart';
import '../../domain/faculty/Faculty.dart';
import '../../domain/faculty/Chair.dart';
import '../../domain/faculty/IFacultyManager.dart';

typedef Future<T> RepeatableFunction<T>();

class FacultyManager implements IFacultyManager {
  FacultyManager(this._storageProvider, this._networkProvider,
      {AssetManager assetManager}) {
    _assetManager = assetManager ?? new AssetManager(Constants.ASSET_DIRECTORY);
  }

  IProvider<FacultyInfo> _storageProvider;
  IProvider<FacultyInfo> _networkProvider;

  AssetManager _assetManager;

  static const int _networkRequestAttemptsCountt = 3;

  @override
  List<Chair> getChairs() {
    throw new UnimplementedError("Not implemented.");
  }

  @override
  List<int> getYears() {
    throw new UnimplementedError("Not implemented.");
  }

  @override
  Future<List<Faculty>> getFaculties() async {
    var faculties = await _storageProvider.getList();
    if (faculties.length == 0) {
      faculties = await _executeWithRepeats(
              () async => await _networkProvider.getList(),
              _networkRequestAttemptsCountt) ??
          <FacultyInfo>[];
      await _storageProvider.insertAll(faculties);
    }

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
  List<Group> getGroups(GroupLoadOptions loadOptions) {
    throw new UnimplementedError("Not implemented.");
  }
}
