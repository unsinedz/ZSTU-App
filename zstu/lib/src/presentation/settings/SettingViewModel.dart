import 'dart:ui';

import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';
import 'package:zstu/src/resources/Texts.dart';

class SettingViewModel<T> extends BaseViewModel implements ILocaleSensitive {
  SettingViewModel(this.name, {this.stringValue, this.type, this.value});

  String name;

  String stringValue;

  String type;

  T value;

  @override
  void initializeForLocale(Locale locale) {
    name = Texts.getText(name, locale.languageCode);
    stringValue = Texts.getText(stringValue, locale.languageCode);
    type = Texts.getText(type, locale.languageCode);
  }
}
