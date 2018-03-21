import 'dart:async';
import '../../common/provider/IProvider.dart';
import '../FacultyInfo.dart';
import '../../Constants.dart';
import '../../common/provider/ApiProviderBase.dart';
import '../../common/provider/GeneralNetworkProvider.dart';

class FacultyApiProvider extends ApiProviderBase
    implements IProvider<FacultyInfo> {
  FacultyApiProvider(GeneralNetworkProvider _baseProvider)
      : super(Constants.API_URI, _baseProvider);

  static const Map<String, String> _paths = const {
    "faculty": "/faculty",
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
    var result = new List<FacultyInfo>();
    var response = await getJson(_paths["faculty"], params: {"pageSize": Constants.BATCH_SIZE.toString()});
    while (response.count > 0) {
      result.addAll(response.items.map((x) => new FacultyInfo.fromMap(x)));
      response = await getJson(_paths["faculty"]);
    }

    return result;
  }
}
