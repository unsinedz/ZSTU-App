import 'package:zstu/src/domain/common/serialization/IValueSerializer.dart';
import 'package:zstu/src/domain/common/serialization/JsonSerializer.dart';
import 'package:zstu/src/domain/common/serialization/StringSerializer.dart';

class ValueSerializerFactory {
  static ValueSerializerFactory _instance;
  static ValueSerializerFactory get instance => _instance = _instance ?? new ValueSerializerFactory();

  IValueSerializer getSerializerForGenericType<T>() {
    return getSerializerForType(T);
  }

  IValueSerializer getSerializerForType(Type type) {
    switch (type)
    {
      case String:
        return new StringSerializer((x) => x);

      case num:
      case int:
      case double:
        return new StringSerializer((x) => num.parse(x) as double);

      case bool:
        return new StringSerializer((x) => x == 'true');

      default:
        return new JsonSerializer();
    }
  }
}