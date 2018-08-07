import 'dart:async';
import 'package:zstu/src/data/common/ApiResponse.dart';
import 'package:zstu/src/data/faculty/provider/FacultyApiProvider.dart';

abstract class INetworkExecutor {
  Future<List<T>> getEntities<T>(String apiPath, Map<String, String> params,
      FromMapBuilder<T> fromMapBuilder);

  Future<ApiResponse> getJson(String path, {Map<String, String> params});

  Future handleStatusCode(String code);
}
