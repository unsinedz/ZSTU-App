import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

class EditableSetting<T> {
  EditableSetting({
    @required this.name,
    @required this.previewValue,
    this.value,
    this.valueChanged,
    this.valueDescriptor,
  });

  final String name;

  final String previewValue;

  final T value;

  final ValueChanged<T> valueChanged;

  final IValueDescriptor<T> valueDescriptor;
}
