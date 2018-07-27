import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';

class GenericDescriptor<T extends Object> implements IValueDescriptor<T> {
  GenericDescriptor(this._possibleValues);

  List<NamedValue<T>> _possibleValues;

  @override
  List<NamedValue<T>> getPossibleValues() {
    return _possibleValues;
  }

  @override
  bool canBeStringified() {
    switch (T) {
      case num:
      case int:
      case double:
      case bool:
      case String:
        return true;
      default:
        return false;
    }
  }

  @override
  String stringify<T>(T value) {
    return value.toString();
  }
}
