import 'dart:ui';

abstract class ILocaleProvider {
  Locale getApplicationLocale();
  bool isLocaleSupported(Locale locale);
  void initialize(Locale locale);
}