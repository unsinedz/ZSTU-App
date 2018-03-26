import 'dart:async';
import '../../../domain/faculty/GroupLoadOptions.dart';
import '../FacultyInfo.dart';
import '../../Constants.dart';
import '../../common/provider/ApiProviderBase.dart';
import '../../common/provider/GeneralNetworkProvider.dart';
import '../YearInfo.dart';
import '../GroupInfo.dart';
import 'IFacultyProvider.dart';

typedef T FromMapBuilder<T>(dynamic map);

class FacultyApiProvider extends ApiProviderBase implements IFacultyProvider {
  FacultyApiProvider(GeneralNetworkProvider _baseProvider)
      : super(Constants.API_URI, _baseProvider);

  static const Map<String, String> _paths = const {
    "faculty": "/faculty",
    "group": "/group",
    "year": "/year",
  };

  @override
  Future insert(FacultyInfo obj) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future insertAll(List<FacultyInfo> objList) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future<FacultyInfo> getById(String id) async {
    var response = await getJson(_paths["faculty"], params: {"id": id});
    if (response.count == 0) return null;

    return new FacultyInfo.fromMap(response.items[0]);
  }

  @override
  Future<List<FacultyInfo>> getList() async {
    return await _getEntities(
        _paths["faculty"], {}, (x) => new FacultyInfo.fromMap(x));
  }

  @override
  Future<List<GroupInfo>> getGroups(GroupLoadOptions loadOptions) async {
    assert(loadOptions != null);

    var params = {
      "faculty": loadOptions.faculty.id,
      "year": loadOptions.year.id,
    };

    var groupMaps = await _getEntities(_paths["group"], params, (x) => x);
    for (int i = 0; i < groupMaps.length; i++) {
      var facultyId = groupMaps[i]["faculty"];
      var yearId = groupMaps[i]["year"];
      if (facultyId != loadOptions.faculty.id || yearId != loadOptions.year.id) {
        groupMaps.removeAt(i--);
        continue;
      }

      groupMaps[i]["faculty"] = loadOptions.faculty;
      groupMaps[i]["year"] = loadOptions.year;
    }

    return groupMaps.map((x) => new GroupInfo.fromMap(x)).toList();
  }

  @override
  Future<List<YearInfo>> getYears() async {
    return await _getEntities(_paths["year"], {}, (x) => new YearInfo.fromMap(x));
  }

  @override
  Future insertAllGroups(List<GroupInfo> groups) {
    throw new Exception("Api insertions are not supported.");
  }

  @override
  Future insertAllYears(List<YearInfo> years) {
    throw new Exception("Api insertions are not supported.");
  }

  Future<List<T>> _getEntities<T>(String apiPath, Map<String, String> params,
      FromMapBuilder<T> fromMapBuilder) async {
    assert(apiPath != null);
    assert(params != null);
    assert(fromMapBuilder != null);

    var pageSize = params["pageSize"];
    if (pageSize == null) {
      pageSize = Constants.BATCH_SIZE.toString();
      params["pageSize"] = pageSize;
    }

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
