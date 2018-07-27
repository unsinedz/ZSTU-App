import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:zstu/src/core/locale/ILocaleProvider.dart';
import 'package:zstu/src/core/locale/ISupportsLocaleOverride.dart';

class DefaultLocaleProvider
    implements ILocaleProvider, ISupportsLocaleOverride {
  static const supportedLocales = ["en", "ru", "uk"];

  static ILocaleProvider _instance;
  static ILocaleProvider get instance =>
      _instance = _instance ?? new DefaultLocaleProvider();

  static String buildLocaleKey({@required String localeCode}) {
    return "Locale_" + localeCode;
  }

  Locale _applicationLocale;
  Locale _overridenLocale;

  void initialize(Locale applicationLocale) {
    _applicationLocale = applicationLocale;
  }

  void overrideLocale(Locale locale) {
    _overridenLocale = locale;
  }

  bool canOverrideLocaleWith(Locale locale) {
    return locale?.languageCode != _applicationLocale?.languageCode &&
        (_overridenLocale == null ||
            _overridenLocale?.languageCode != locale.languageCode);
  }

  @override
  Locale getApplicationLocale() {
    return _overridenLocale ?? _applicationLocale;
  }

  @override
  bool isLocaleSupported(Locale locale) {
    return supportedLocales.contains(locale?.languageCode);
  }
}
