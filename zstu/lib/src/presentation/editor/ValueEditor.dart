import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

abstract class ValueEditor<T> {
  @protected
  T value;

  @protected
  IValueDescriptor<T> valueDescriptor;

  @protected
  String title;

  bool get embaddable;

  ValueEditor(T value, IValueDescriptor<T> valueDescriptor, String title)
      : this.value = value,
        this.valueDescriptor = valueDescriptor,
        this.title = title;

  Widget construct(BuildContext context);
}
