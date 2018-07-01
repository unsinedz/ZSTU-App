import 'dart:async';
import 'dart:ui';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/Constants.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/BaseSettings.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';

class SettingsScreenViewModel extends BaseViewModel
    implements ILocaleSensitive {
  List<SettingViewModel> settingValues;

  static final String settingLocalizationKeyPrefix =
      Constants.localizationKeyPrefixes.setting;

  @override
  Future initialize() async {
    var applicationSettings = await new App().settings.getApplicationSettings();
    settingValues = <SettingViewModel>[];

    // Application settings
    for (var setting in <BaseSettings>[
      applicationSettings,
      applicationSettings.system,
    ]) settingValues.addAll(_extractSettingValues(setting));

    await super.initialize();
  }

  List<SettingViewModel> _extractSettingValues(BaseSettings settings) {
    var items = <SettingViewModel>[];
    var descriptors = new App().valueDescriptors;
    for (var settingName in settings.getValues().keys) {
      var key = BaseSettings.makeSettingKey(settingName, type: settings.type);
      var value = settings.getSetting(settingName);
      var valueDescriptor = descriptors.safeGetValueDescriptor(key) ??
          descriptors.safeGetValueDescriptor(value.runtimeType);
      var stringValue = (valueDescriptor?.canBeStringified() ?? false)
          ? value.toString()
          : null;
      items.add(new SettingViewModel(
        key,
        stringValue: stringValue,
        type: settings.type,
        value: value,
      ));
    }

    return items;
  }

  @override
  void initializeForLocale(Locale locale) {
    settingValues?.forEach((x) => x.initializeForLocale(locale));
  }
}
