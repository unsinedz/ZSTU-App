import 'dart:async';
import 'dart:ui';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/settings/foundation/AdditionalSettingListItemsStorage.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/presentation/settings/AdditionalSettingItemViewModel.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';

class SettingsScreenViewModel extends BaseViewModel
    with FutureHelperMixin
    implements ILocaleSensitive {
  List<ISettingListItemModel> settingValues = [];

  @override
  Future initialize() async {
    settingValues.addAll(AdditionalSettingListItemsStorage.instance
        .getItems()
        .map((x) => new AdditionalSettingItemViewModel(x))
        .toList());

    var editableSettings = await new App().settings.getEditableSettings();
    settingValues.addAll(editableSettings
        .map((x) => new SettingViewModel.fromEditableSetting(x))
        .toList());

    await super.initialize();
  }

  @override
  void initializeForLocale(Locale locale) {
    settingValues
        ?.where((x) => x is ILocaleSensitive)
        ?.cast<ILocaleSensitive>()
        ?.forEach((x) => x.initializeForLocale(locale));
  }
}
