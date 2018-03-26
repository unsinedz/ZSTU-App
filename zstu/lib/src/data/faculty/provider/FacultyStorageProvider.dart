import 'dart:async';
import '../../../domain/faculty/GroupLoadOptions.dart';
import '../../../domain/faculty/Group.dart';
import '../../../domain/faculty/IFacultyProvider.dart';
import '../FacultyInfo.dart';
import '../../common/provider/GeneralStorageProvider.dart';
import '../../common/provider/IProvider.dart';

class FacultyStorageProvider implements IProvider<FacultyInfo>, IFacultyProvider {
  static const String TableName = "Faculties";

  FacultyStorageProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  @override
  Future insert(FacultyInfo obj) async {
    assert(obj != null);

    await _baseProvider.transaction((t) async {
      await _baseProvider.insertMap(TableName, obj.toMap(), executor: t);
    });
  }

  @override
  Future insertAll(List<FacultyInfo> objList) async {
    assert(objList != null);

    if (objList.length == 0) return;
    
    await _baseProvider.transaction((t) async {
      for (FacultyInfo fi in objList) {
        _baseProvider.insertMap(TableName, fi.toMap(), executor: t);
      }
    });
  }

  @override
  Future<FacultyInfo> getById(String id) async {
    assert(id != null && id.isNotEmpty);

    var map = await _baseProvider.getEntityMap(TableName, id);
    return new FacultyInfo.fromMap(map);
  }

  @override
  Future<List<FacultyInfo>> getList() async {
    var data = await _baseProvider.getMapList(TableName);
    return data.map((x) => new FacultyInfo.fromMap(x)).toList();
  }

  @override
  List<Group> getGroups(GroupLoadOptions loadOptions) {
    throw new UnimplementedError('Not implemented.');
  }

  @override
  List<int> getYears() {
    throw new UnimplementedError('Not implemented.');
  }
}
