import 'dart:async';
import '../../../domain/faculty/GroupLoadOptions.dart';
import '../FacultyInfo.dart';
import '../../common/provider/GeneralStorageProvider.dart';
import '../YearInfo.dart';
import '../GroupInfo.dart';
import 'IFacultyProvider.dart';

typedef Map MapSelector<T>(T entity);

class FacultyStorageProvider implements IFacultyProvider {
  static const String FacultyTableName = "Faculties";
  static const String GroupTableName = "Groups";
  static const String YearTableName = "Years";

  FacultyStorageProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  @override
  Future insert(FacultyInfo obj) async {
    assert(obj != null);

    await insertAll(<FacultyInfo>[obj]);
  }

  @override
  Future insertAll(List<FacultyInfo> faculties) async {
    await _insertAllEntities(
        FacultyTableName, faculties, (FacultyInfo x) => x.toMap());
  }

  @override
  Future<FacultyInfo> getById(String id) async {
    assert(id != null && id.isNotEmpty);

    var map = await _baseProvider.getEntityMap(FacultyTableName, id);
    return new FacultyInfo.fromMap(map);
  }

  @override
  Future<List<FacultyInfo>> getList() async {
    var data = await _baseProvider.getMapList(FacultyTableName);
    return data.map((x) => new FacultyInfo.fromMap(x)).toList();
  }

  @override
  Future<List<GroupInfo>> getGroups(GroupLoadOptions loadOptions) async {
    var data = await _baseProvider.getMapList(GroupTableName);
    for (Map<String, dynamic> map in data) {
      var facultyId = map["facultyId"];
      if (facultyId == null)
        throw new Exception(
            "Database integrity corruption. Group has null faculty id.");

      map.remove('facultyId');
      var faculty = await getById(facultyId);
      map["faculty"] = faculty;
    }

    return data.map((x) => new GroupInfo.fromMap(x));
  }

  @override
  Future<List<YearInfo>> getYears() async {
    var data = await _baseProvider.getMapList(YearTableName);
    return data.map((x) => new YearInfo.fromMap(x)).toList();
  }

  @override
  Future insertAllGroups(List<GroupInfo> groups) async {
    assert(groups != null);

    if (groups.length == 0) return;

    await _baseProvider.transaction((t) async {
      for (GroupInfo gi in groups) {
        var map = gi.toMap();
        FacultyInfo faculty = map["faculty"];
        YearInfo year = map["year"];
        map.remove("year");
        map.remove("faculty");
        map["facultyId"] = faculty.id;
        map["yearId"] = year.id;

        await _baseProvider.insertMap(GroupTableName, map, executor: t);
      }
    });
  }

  @override
  Future insertAllYears(List<YearInfo> years) async {
    await _insertAllEntities(YearTableName, years, (YearInfo x) => x.toMap());
  }

  Future _insertAllEntities<T>(
      String tableName, List<T> entities, MapSelector<T> mapSelector) async {
    assert(tableName != null);
    assert(entities != null);
    assert(mapSelector != null);

    if (entities.length == 0) return;

    await _baseProvider.transaction((t) async {
      for (T entity in entities) {
        await _baseProvider.insertMap(tableName, mapSelector(entity),
            executor: t);
      }
    });
  }
}
