import 'dart:ui';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/resources/Texts.dart';

class NamedValue<T> implements ILocaleSensitive {
  NamedValue(this.name, this.value);

  String name;

  T value;

  @override
  void initializeForLocale(Locale locale) {
    name = Texts.getText(name, locale.languageCode, name);
  }
}
