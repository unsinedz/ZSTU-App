import 'dart:ui';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingListItem.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/resources/Texts.dart';

class AdditionalSettingItemViewModel
    implements ISettingListItemModel, ILocaleSensitive {
  AdditionalSettingItemViewModel(ISettingListItem item) {
    this.name = item.name;
    this.translatedName = item.name;
    this.type = item.type;
    this.translatedType = item.type;
  }

  TapHandler onTap;

  @override
  String name;

  @override
  String translatedName;

  @override
  String type;

  @override
  String translatedType;

  @override
  IValueDescriptor valueDescriptor;

  @override
  void initializeForLocale(Locale locale) {
    translatedName = Texts.getText(
        _makeLocalizationKey(name, type), locale.languageCode, name);
    if (type?.isNotEmpty ?? false)
      translatedType =
          Texts.getText(_makeLocalizationKey(type), locale.languageCode, type);
  }

  String _makeLocalizationKey(String name, [String type]) {
    return BaseSettings.makeSettingKey(name, type: type);
  }
}
