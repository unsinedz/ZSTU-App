import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';

abstract class IValueDescriptor<T> {
  List<NamedValue<T>> getPossibleValues();
  bool canBeStringified();
  String stringify<T>(T value);
}
