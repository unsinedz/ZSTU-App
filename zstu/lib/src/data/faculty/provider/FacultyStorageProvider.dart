import 'dart:async';
import '../../../domain/faculty/ChairLoadOptions.dart';
import '../../../domain/faculty/Chair.dart';
import '../../../domain/faculty/Faculty.dart';
import '../../../domain/faculty/Group.dart';
import '../../../domain/faculty/GroupLoadOptions.dart';
import '../../../domain/faculty/IFacultyProvider.dart';
import '../../../domain/faculty/Year.dart';
import '../ChairInfo.dart';
import '../FacultyInfo.dart';
import '../../common/provider/GeneralStorageProvider.dart';
import '../YearInfo.dart';
import '../GroupInfo.dart';
import '../../Constants.dart';
import 'FacultyProviderMixin.dart';
import 'MemoryCacheMixin.dart';

typedef Map<String, dynamic> MapSelector<T>(T entity);

class FacultyStorageProvider extends FacultyProviderMixin
    with MemoryCacheMixin
    implements IFacultyProvider {
  FacultyStorageProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  String get FacultyTableName => Constants.FacultyTableName;
  String get GroupTableName => Constants.GroupTableName;
  String get YearTableName => Constants.YearTableName;
  String get ChairTableName => Constants.ChairTableName;
  String get TeacherTableName => Constants.TeacherTableName;

  @override
  Future insert(Faculty faculty) async {
    assert(faculty != null);

    await insertAll(<Faculty>[faculty]);
  }

  @override
  Future insertAll(List<Faculty> faculties) {
    return _insertAllEntities(FacultyTableName, faculties,
        (Faculty x) => new FacultyInfo.fromFaculty(x).toMap());
  }

  @override
  Future<Faculty> getById(String id) async {
    assert(id != null && id.isNotEmpty);

    var map = await _baseProvider.getEntityMap(FacultyTableName, id);
    return makeFaculty(new FacultyInfo.fromMap(map));
  }

  @override
  Future<List<Faculty>> getList() async {
    var data = await _baseProvider.getMapList(FacultyTableName);
    return data.map((x) => makeFaculty(new FacultyInfo.fromMap(x))).toList();
  }

  @override
  Future<List<Group>> getGroups(GroupLoadOptions loadOptions) async {
    assert(loadOptions != null);

    var data = await _baseProvider.getMapList(
      GroupTableName,
      where: 'facultyId LIKE ? AND yearId LIKE ?',
      whereArgs: [
        loadOptions.faculty?.id ?? '%',
        loadOptions.year?.id ?? '%',
      ],
    );

    return new Stream.fromIterable(data)
        .asyncMap((x) => makeGroup(
              new GroupInfo.fromMap(x),
              (id) => getAndCacheFaculty(id, getById),
            ))
        .toList();
  }

  @override
  Future insertAllGroups(List<Group> groups) {
    return _insertAllEntities(
        GroupTableName, groups, (x) => new GroupInfo.fromGroup(x).toMap());
  }

  @override
  Future<List<Year>> getYears() async {
    var data = await _baseProvider.getMapList(YearTableName);
    return data.map((x) => makeYear(new YearInfo.fromMap(x))).toList();
  }

  @override
  Future insertAllYears(List<Year> years) {
    return _insertAllEntities(
        YearTableName, years, (Year x) => new YearInfo.fromYear(x).toMap());
  }

  @override
  Future<List<Chair>> getChairs(ChairLoadOptions loadOptions) async {
    assert(loadOptions != null);

    var data = await _baseProvider.executeQuery('''
      SELECT C.id, C.name 
      FROM ? AS C
      ${loadOptions.teacher == null ? 'LEFT' : 'INNER'} JOIN ? AS T ON 'T.chairId LIKE C.id'
      WHERE F.id LIKE ?
        and T.id like ?
    ''', arguments: [
      ChairTableName,
      TeacherTableName,
      loadOptions.faculty?.id ?? '%',
      loadOptions.teacher?.chair?.id ?? '%',
    ]);
    return data.map((x) => makeChair(new ChairInfo.fromMap(x))).toList();
  }

  @override
  Future insertAllChairs(List<Chair> chairs) {
    return _insertAllEntities(ChairTableName, chairs,
        (Chair x) => new ChairInfo.fromChair(x).toMap());
  }

  Future _insertAllEntities<T>(
      String tableName, List<T> entities, MapSelector<T> mapSelector) async {
    assert(tableName != null);
    assert(entities != null);
    assert(mapSelector != null);

    if (entities.length == 0) return;

    await _baseProvider.transaction((t) async {
      var batch = _baseProvider.batch();
      for (T entity in entities)
        _baseProvider.batchInsertMap(tableName, batch, mapSelector(entity));

      await t.applyBatch(batch, noResult: true);
      return t;
    });
  }
}
