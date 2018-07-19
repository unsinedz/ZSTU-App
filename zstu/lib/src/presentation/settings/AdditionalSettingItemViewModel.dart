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
    name = item.name;
    type = item.type;
  }

  TapHandler onTap;

  @override
  String name;

  @override
  String type;

  @override
  IValueDescriptor valueDescriptor;

  @override
  void initializeForLocale(Locale locale) {
    name = Texts.getText(
        _makeLocalizationKey(name, type), locale.languageCode, name);
    type = Texts.getText(_makeLocalizationKey(type), locale.languageCode, type);
  }

  String _makeLocalizationKey(String name, [String type]) {
    return BaseSettings.makeSettingKey(name, type: type);
  }
}
