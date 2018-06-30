import 'dart:convert';
import 'package:zstu/src/domain/common/serialization/IValueSerializer.dart';

class JsonSerializer implements IValueSerializer {
  dynamic deserialize(String rawValue) {
    return json.decode(rawValue);
  }

  String serialize(dynamic value) {
    return json.encode(value);
  }
}
