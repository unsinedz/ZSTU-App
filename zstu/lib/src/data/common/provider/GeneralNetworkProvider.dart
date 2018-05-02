import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../../App.dart';

class GeneralNetworkProvider {
  GeneralNetworkProvider({HttpClient client}) {
    _client = client ?? new HttpClient();
  }

  HttpClient _client;

  Future<String> getString(String uri, String path, Map<String, String> params, {Converter<List<int>, String> decoder}) async {
    decoder = decoder ?? utf8.decoder;

    var url = new Uri.http(uri, path, params);

    if (new App().settings.enableLogging)
      print("Request details: ${url.toString()}");

    var request = await _client.getUrl(url);
    var response = await request.close();
    return await response.transform(decoder).join();
  }

  Future<Map<String, dynamic>> getJson(String uri, String path, Map<String, String> params, {Converter<List<int>, String> decoder}) async {
    var body = await getString(uri, path, params, decoder: decoder);
    if (body == null || body.isEmpty) return null;

    return json.decode(body);
  }
}