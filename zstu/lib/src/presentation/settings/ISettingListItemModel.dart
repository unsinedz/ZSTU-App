import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

typedef void TapHandler(BuildContext context);

abstract class ISettingListItemModel {
  String get name;
  String get type;
  IValueDescriptor get valueDescriptor;
  TapHandler get onTap;
}
