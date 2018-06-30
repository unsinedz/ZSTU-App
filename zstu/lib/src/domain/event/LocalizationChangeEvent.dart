import 'dart:ui';

import 'package:zstu/src/core/event/Event.dart';

class LocalizationChangeEvent extends Event {
  LocalizationChangeEvent(this.locale, {List<Object> arguments})
      : super(Name, arguments: arguments);

  static const String Name = 'LocalizationChange';

  Locale locale;
}
