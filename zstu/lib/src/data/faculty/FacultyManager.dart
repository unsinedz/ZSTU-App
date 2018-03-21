import 'dart:async';
import 'package:connectivity/connectivity.dart';
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

class FacultyManager implements IFacultyManager {
  FacultyManager(this._storageProvider, this._networkProvider);

  IProvider<FacultyInfo> _storageProvider;
  IProvider<FacultyInfo> _networkProvider;

  AssetManager _assetManager = new AssetManager(Constants.ASSET_DIRECTORY);

  static const List<String> _supportedImageExtensions = const [
    ".png",
    ".jpg",
    ".jpeg"
  ];

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
    var connection = await (new Connectivity().checkConnectivity());
    bool connected = connection != ConnectivityResult.none;

    var faculties = await _storageProvider.getList();
    if (connected && faculties.length == 0) {
      faculties = await _networkProvider.getList();
      await _storageProvider.insertAll(faculties);
    }

    await loadFacultyImages(faculties);

    return faculties.map((x) => x.toFaculty()).toList();
  }

  Future loadFacultyImages(List<FacultyInfo> faculties) async {
    if (faculties == null)
      throw new ArgumentError('Error loading images to null collection.');
    await for (FacultyInfo f in new Stream.fromIterable(faculties)) {
      for (String ext in _supportedImageExtensions) {
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
