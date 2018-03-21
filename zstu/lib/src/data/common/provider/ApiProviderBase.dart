import 'dart:async';

import '../ApiResponse.dart';
import 'GeneralNetworkProvider.dart';

abstract class ApiProviderBase {
  ApiProviderBase(this._uri, this._baseProvider);

  GeneralNetworkProvider _baseProvider;
  String _uri;

  Future<ApiResponse> getJson(String path,
      {Map<String, dynamic> params}) async {
    var map = await _baseProvider.getJson(_uri, path, params);
    return new ApiResponse.fromMap(map);
  }
}
