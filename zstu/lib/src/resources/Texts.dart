import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zstu/src/core/locale/ILocaleProvider.dart';
import 'package:zstu/src/core/locale/ITextProvider.dart';
import 'package:zstu/src/resources/texts/Texts.en.dart';
import 'package:zstu/src/resources/texts/Texts.ru.dart';
import 'package:zstu/src/resources/texts/Texts.uk.dart';

class Texts {
  Texts(this._localeProvider);

  static Texts of(BuildContext context) {
    return Localizations.of<Texts>(context, Texts);
  }

  final ILocaleProvider _localeProvider;
  Locale get _locale => _localeProvider.getApplicationLocale();

  String get appName => this["appName"];

  String get scheduleTitle => this["scheduleTitle"];
  String get myScheduleTitle => this["myScheduleTitle"];
  String get facultiesTitle => this["facultiesTitle"];
  String get groupTitle => this["groupTitle"];
  String get teachersTitle => this["teachersTitle"];
  String get newsTitle => this["newsTitle"];
  String get learnPortalTitle => this["learnPortalTitle"];
  String get settingsTitle => this["settingsTitle"];
  String get aboutTitle => this["aboutTitle"];

  String get fict => this["fict"];
  String get fem => this["fem"];
  String get mef => this["mef"];
  String get faf => this["faf"];
  String get fme => this["fme"];

  String get facultiesGridTitle => this["facultiesGridTitle"];

  String get mondayShort => this["mondayShort"];
  String get tuesdayShort => this["tuesdayShort"];
  String get wednesdayShort => this["wednesdayShort"];
  String get thursdayShort => this["thursdayShort"];
  String get fridayShort => this["fridayShort"];
  String get saturdayShort => this["saturdayShort"];
  String get sundayShort => this["sundayShort"];

  String get selectGroupAndYear => this["selectGroupAndYear"];
  String get yearSelectorPlaceholder => this["yearSelectorPlaceholder"];
  String get yearSelectorLabel => this["yearSelectorPlaceholder"];
  String get groupSelectorPlaceholder => this["groupSelectorPlaceholder"];
  String get groupSelectorLabel => this["groupSelectorLabel"];
  String get selectYearFirst => this["selectYearFirst"];

  String get year => this["year"];

  String get findSchedule => this["findSchedule"];

  String get scheduleDayOff => this["scheduleDayOff"];

  String get featureNotAvailable => this["featureNotAvailable"];
  String get noConnection => this["noConnection"];

  String get dataLoadError => this["dataLoadError"];

  String get somethingWentWrong => this["somethingWentWrong"];

  String get applicationLanguage => this["Setting_General_applicationLanguage"];

  static final List<ITextProvider> _textProviders = [
    const TextsEn(),
    const TextsRu(),
    const TextsUk(),
  ];

  operator [](String key) => getText(key, this._locale.languageCode, key);

  static String getText(String key, String languageCode,
      [String defaultValue]) {
    assert(key != null);
    assert(languageCode != null);

    var provider = _textProviders
        .firstWhere((provider) => provider.locale.languageCode == languageCode);
    if (provider == null)
      throw new StateError(
          'Localizations are not defined for locale $languageCode.');

    return provider.getText(key) ?? defaultValue;
  }
}

class TextsDelegate extends LocalizationsDelegate<Texts> {
  TextsDelegate(this._localeProvider);

  final ILocaleProvider _localeProvider;

  @override
  bool isSupported(Locale locale) => _localeProvider.isLocaleSupported(locale);

  @override
  Future<Texts> load(Locale locale) =>
      new Future<Texts>.value(new Texts(_localeProvider));

  @override
  bool shouldReload(LocalizationsDelegate<Texts> old) => false;
}
