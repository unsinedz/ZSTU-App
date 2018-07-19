import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingListItem.dart';

class AdditionalSettingItem implements ISettingListItem {
  AdditionalSettingItem({
    @required this.type,
    @required this.name,
    this.valueDescriptor,
  });

  String type;

  String name;

  IValueDescriptor valueDescriptor;
}
