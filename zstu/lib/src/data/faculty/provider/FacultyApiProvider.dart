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
import '../../Constants.dart';
import '../../common/provider/NetworkProviderBase.dart';
import '../../common/provider/GeneralNetworkProvider.dart';
import '../YearInfo.dart';
import '../GroupInfo.dart';
import 'FacultyProviderMixin.dart';

typedef T FromMapBuilder<T>(dynamic map);

class FacultyApiProvider extends NetworkProviderBase
    with FacultyProviderMixin
    implements IFacultyProvider {
  FacultyApiProvider(GeneralNetworkProvider _baseProvider)
      : super(Constants.API_URI, _baseProvider);

  static const Map<String, String> _paths = const {
    "faculty": "/faculty",
    "group": "/group",
    "year": "/year",
    "chair": "/chair",
  };

  @override
  Future insert(Faculty obj) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future insertAll(List<Faculty> objList) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future<Faculty> getById(String id) async {
    var response = await getJson(_paths["faculty"], params: {"id": id});
    if (response.count == 0) return null;

    return makeFaculty(new FacultyInfo.fromMap(response.items[0]));
  }

  @override
  Future<List<Faculty>> getList() async {
    return await _getEntities(
        _paths["faculty"], {}, (x) => makeFaculty(new FacultyInfo.fromMap(x)));
  }

  @override
  Future<List<Chair>> getChairs(ChairLoadOptions loadOptions) async {
    assert(loadOptions != null);

    var params = {
      "faculty": loadOptions.faculty?.id,
      "teacher": loadOptions.teacher?.id,
    };

    return _getEntities(
        _paths["chair"], params, (x) => makeChair(new ChairInfo.fromMap(x)));
  }

  @override
  Future<List<Group>> getGroups(GroupLoadOptions loadOptions) async {
    assert(loadOptions != null);

    var params = {
      "faculty": loadOptions.faculty?.id,
      "year": loadOptions.year?.id,
    };

    var data = await _getEntities(_paths["group"], params, (x) => x);
    return new Stream.fromIterable(data)
        .asyncMap((x) async => makeGroup(new GroupInfo.fromMap(x), (i) => getById(i)))
        .toList();
  }

  @override
  Future<List<Year>> getYears() async {
    return await _getEntities(
        _paths["year"], {}, (x) => makeYear(new YearInfo.fromMap(x)));
  }

  @override
  Future insertAllGroups(List<Group> groups) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future insertAllYears(List<Year> years) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future insertAllChairs(List<Chair> chairs) {
    throw new Exception("Api insertions are not supported.");
  }

  Future<List<T>> _getEntities<T>(String apiPath, Map<String, String> params,
      FromMapBuilder<T> fromMapBuilder) async {
    assert(apiPath != null);
    assert(params != null);
    assert(fromMapBuilder != null);

    if (params["pageSize"] == null)
      params["pageSize"] = Constants.BATCH_SIZE.toString();

    var page = 0;
    params["page"] = page.toString();

    var result = new List<T>();
    var response = await getJson(apiPath, params: params);
    while (response.count > 0) {
      result.addAll(response.items.map(fromMapBuilder).toList());
      params["page"] = (++page).toString();
      response = await getJson(apiPath, params: params);
    }

    return result;
  }
}
