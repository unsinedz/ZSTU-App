import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingListItem.dart';

class EditableSetting<T> implements ISettingListItem {
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
