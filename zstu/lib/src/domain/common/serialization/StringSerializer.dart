import 'package:zstu/src/domain/common/serialization/IValueSerializer.dart';

typedef T FromStringParser<T>(String s);

class StringSerializer implements IValueSerializer {
  StringSerializer(this._parser);

  final FromStringParser _parser;

  @override
  dynamic deserialize(String rawValue) {
    return _parser(rawValue);
  }

  @override
  String serialize(dynamic value) {
    return value?.toString();
  }
}
