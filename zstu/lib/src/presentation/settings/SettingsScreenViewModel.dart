import 'dart:async';
import 'dart:ui';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/presentation/settings/AdditionalSettingItemViewModel.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/ISettingValueItem.dart';
import 'package:zstu/src/presentation/settings/ITypedSettingItem.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';

class SettingsScreenViewModel extends BaseViewModel
    with FutureHelperMixin
    implements ILocaleSensitive {
  List<ISettingListItemModel> settingValues = [];

  @override
  Future initialize() {
    return new App()
        .settings
        .getSettingListItems()
        .then((settingListItems) => settingValues.addAll(settingListItems
            .map((x) => x is EditableSetting
                ? new SettingViewModel.fromEditableSetting(x)
                : new AdditionalSettingItemViewModel(x))
            .cast<ISettingListItemModel>()
            .toList()))
        .whenComplete(() => super.initialize());
  }

  @override
  void initializeForLocale(Locale locale) {
    settingValues
        ?.where((x) => x is ILocaleSensitive)
        ?.forEach((x) => (x as ILocaleSensitive).initializeForLocale(locale));
  }

  Future<bool> updateSettingItem(
      ISettingListItemModel setting, dynamic newValue) {
    if (setting is ISettingValueItem && setting is ITypedSettingItem) {
      (setting as ISettingValueItem).value = newValue;
      var settingsManager = new App().settings;
      return settingsManager.modifySettings<BaseSettings>(
          settingsManager.getSettings<BaseSettings>(setting.type), (s) {
        var valueType = (setting as ITypedSettingItem).valueType;
        if (s.getSetting(setting.name, valueType) == newValue) return false;

        s.setSetting(setting.name, newValue, valueType);
        return true;
      });
    }

    return new Future.value(false);
  }
}
