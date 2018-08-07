import 'dart:async';
import 'package:zstu/src/data/common/INetworkExecutor.dart';

import '../../../domain/Constants.dart';
import '../ApiResponse.dart';
import 'GeneralNetworkProvider.dart';

typedef T FromMapBuilder<T>(dynamic map);

abstract class NetworkProviderBase implements INetworkExecutor {
  NetworkProviderBase(this._uri, this._baseProvider);

  GeneralNetworkProvider _baseProvider;
  String _uri;

  Future<ApiResponse> getJson(String path, {Map<String, String> params}) async {
    var map = await _baseProvider.getJson(_uri, path, params);
    return new ApiResponse.fromMap(map);
  }

  Future<List<T>> getEntities<T>(String apiPath, Map<String, String> params,
      FromMapBuilder<T> fromMapBuilder) async {
    assert(apiPath != null);
    assert(params != null);
    assert(fromMapBuilder != null);

    if (params["pageSize"] == null)
      params["pageSize"] = Constants.BatchSize.toString();

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

  Future handleStatusCode(String code) {
    return new Future.value(null);
  }
}
