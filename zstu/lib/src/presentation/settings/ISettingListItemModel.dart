import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

typedef void TapHandler(BuildContext context);

abstract class ISettingListItemModel {
  String get name;
  String get translatedName;
  String get type;
  String get translatedType;
  IValueDescriptor get valueDescriptor;
  TapHandler get onTap;
}
