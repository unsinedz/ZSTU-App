import 'dart:ui';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/resources/Texts.dart';

class SettingViewModel<T> extends BaseViewModel
    implements ISettingListItemModel, ILocaleSensitive {
  SettingViewModel.fromEditableSetting(EditableSetting setting) {
    this.name = setting.name;
    this.translatedName = setting.name;
    this.type = setting.type;
    this.translatedType = setting.type;
    this.value = setting.value;
    this.valueDescriptor = setting.valueDescriptor;
  }

  @override
  String name;

  @override
  String translatedName;

  @override
  String type;

  @override
  String translatedType;

  T value;

  @override
  IValueDescriptor valueDescriptor;

  @override
  TapHandler onTap;

  @override
  void initializeForLocale(Locale locale) {
    translatedName = Texts.getText(
        _makeLocalizationKey(name, type), locale.languageCode, name);
    if (type?.isNotEmpty ?? false)
      translatedType =
          Texts.getText(_makeLocalizationKey(type), locale.languageCode, type);
  }

  String _makeLocalizationKey(String key, [String type]) {
    return BaseSettings.makeSettingKey(key, type: type);
  }
}
