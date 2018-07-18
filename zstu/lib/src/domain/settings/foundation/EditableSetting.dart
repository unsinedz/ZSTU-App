import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

class EditableSetting<T> {
  EditableSetting({
    @required this.valueDescriptor,
    @required this.name,
    this.type,
    this.value,
  });

  final IValueDescriptor<T> valueDescriptor;

  final String name;

  final String type;

  final T value;
}
