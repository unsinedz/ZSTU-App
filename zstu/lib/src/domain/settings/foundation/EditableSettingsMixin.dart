import 'package:zstu/src/core/lang/Tuple.dart';
import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';

abstract class EditableSettingsMixin {
  Tuple<String, T> makeSettingEntry<T>(String name, T value) {
    return new Tuple<String, T>(item1: name, item2: value);
  }

  EditableSetting createEditableSetting<T>(
      ValueDescriptorFactory descriptorFactory,
      String settingName,
      T settingValue,
      {String settingType}) {
    var key = BaseSettings.makeSettingKey(settingName, type: settingType);
    var descriptor = descriptorFactory.getValueDescriptor(key);
    return new EditableSetting<T>(
      valueDescriptor: descriptor,
      name: settingName,
      type: settingType,
      value: settingValue,
    );
  }
}
