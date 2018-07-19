import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

abstract class ISettingListItem {
  String get name;
  String get type;
  IValueDescriptor get valueDescriptor;
}