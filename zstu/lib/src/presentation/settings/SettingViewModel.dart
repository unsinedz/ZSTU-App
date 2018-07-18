import 'dart:ui';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/resources/Texts.dart';

class SettingViewModel<T> extends BaseViewModel implements ILocaleSensitive {
  SettingViewModel.fromEditableSetting(EditableSetting setting) {
    this.name = setting.name;
    this.stringValue = setting.valueDescriptor.canBeStringified()
        ? setting.valueDescriptor.stringify(setting.value)
        : null;
    this.type = setting.type;
    this.value = setting.value;
  }

  String name;

  String stringValue;

  String type;

  T value;

  @override
  void initializeForLocale(Locale locale) {
    name = Texts.getText(
        _makeLocalizationKey(name, type), locale.languageCode, name);
    if (stringValue?.isNotEmpty ?? false)
      stringValue = Texts.getText(_makeLocalizationKey(stringValue, type),
          locale.languageCode, stringValue);

    if (type?.isNotEmpty ?? false)
      type =
          Texts.getText(_makeLocalizationKey(type), locale.languageCode, type);
  }

  String _makeLocalizationKey(String key, [String type]) {
    return BaseSettings.makeSettingKey(key, type: type);
  }
}
