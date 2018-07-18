import 'dart:async';
import 'dart:ui';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';

class SettingsScreenViewModel extends BaseViewModel
    with FutureHelperMixin
    implements ILocaleSensitive {
  List<SettingViewModel> settingValues;

  @override
  Future initialize() async {
    var editableSettings =
        await new App().settings.getEditableSettings();
    settingValues = editableSettings
        .map((x) => new SettingViewModel.fromEditableSetting(x))
        .toList();

    await super.initialize();
  }

  @override
  void initializeForLocale(Locale locale) {
    settingValues?.forEach((x) => x.initializeForLocale(locale));
  }
}
