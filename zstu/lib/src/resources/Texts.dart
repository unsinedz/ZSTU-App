import 'dart:async';
import 'package:flutter/material.dart';

class Texts {
  Texts(this._locale);

  static Texts of(BuildContext context) {
    return Localizations.of<Texts>(context, Texts);
  }

  final Locale _locale;
  static Locale _currentLocale;

  static void setCurrentLocale(Locale locale) {
    assert(locale != null);

    _currentLocale = locale;
  }

  String get appName => _texts["appName"][_locale.languageCode];

  String get scheduleTitle => _texts["scheduleTitle"][_locale.languageCode];
  String get facultiesTitle => _texts["facultiesTitle"][_locale.languageCode];
  String get groupTitle => _texts["groupTitle"][_locale.languageCode];

  String get fict => _texts["fict"][_locale.languageCode];
  String get fem => _texts["fem"][_locale.languageCode];
  String get mef => _texts["mef"][_locale.languageCode];
  String get faf => _texts["faf"][_locale.languageCode];
  String get fme => _texts["fme"][_locale.languageCode];

  String get facultiesGridTitle => _texts["facultiesGridTitle"][_locale.languageCode];

  String get mondayShort => _texts["mondayShort"][_locale.languageCode];
  String get tuesdayShort => _texts["tuesdayShort"][_locale.languageCode];
  String get wednesdayShort => _texts["wednesdayShort"][_locale.languageCode];
  String get thursdayShort => _texts["thursdayShort"][_locale.languageCode];
  String get fridayShort => _texts["fridayShort"][_locale.languageCode];
  String get saturdayShort => _texts["saturdayShort"][_locale.languageCode];
  String get sundayShort => _texts["sundayShort"][_locale.languageCode];

  String get noFacultiesStored => _texts["noFacultiesStored"][_locale.languageCode];

  String get selectGroupAndYear => _texts["selectGroupAndYear"][_locale.languageCode];
  String get yearSelectorPlaceholder => _texts["yearSelectorPlaceholder"][_locale.languageCode];
  String get groupSelectorPlaceholder => _texts["groupSelectorPlaceholder"][_locale.languageCode];
  String get groupSelectorLabel => _texts["groupSelectorLabel"][_locale.languageCode];

  String get year => _texts["year"][_locale.languageCode];

  static String getText(String key, String languageCode, [String defaultValue]) {
    assert(key != null);
    assert(languageCode != null);

    var vals = _texts[key];
    if (vals == null) return defaultValue;

    return vals[languageCode] ?? defaultValue;
  }

  static String getLocalizedText(String key, [String defaultValue]) {
    if (_currentLocale == null)
      return defaultValue ?? key;

    return getText(key, _currentLocale.languageCode, defaultValue);
  }

  static final Map<String, Map<String, String>> _texts = {
    "appName": {
      "en": "ZSTU",
      "ru": "ЖГТУ",
      "uk": "ЖДТУ",
    },
    "facultiesTitle": {
      "en": "Faculties",
      "ru": "Факультеты",
      "uk": "Факультети",
    },
    "scheduleTitle": {
      "en": "Schedule",
      "ru": "Расписание",
      "uk": "Розклад",
    },
    "groupTitle": {
      "en": "Group",
      "ru": "Группа",
      "uk": "Група",
    },
    "mondayShort": {
      "en": "Mon",
      "ru": "Пн",
      "uk": "Пн",
    },
    "tuesdayShort": {
      "en": "Tue",
      "ru": "Вт",
      "uk": "Вт",
    },
    "wednesdayShort": {
      "en": "Wed",
      "ru": "Ср",
      "uk": "Ср",
    },
    "thursdayShort": {
      "en": "Thu",
      "ru": "Чт",
      "uk": "Чт",
    },
    "fridayShort": {
      "en": "Fri",
      "ru": "Пт",
      "uk": "Пт",
    },
    "saturdayShort": {
      "en": "Sat",
      "ru": "Сб",
      "uk": "Сб",
    },
    "sundayShort": {
      "en": "Sun",
      "ru": "Вс",
      "uk": "Нд",
    },
    "ФІКТ": {
      "en": "FICT",
      "ru": "ФИКТ",
      "uk": "ФІКТ",
    },
    "fict": {
      "en": "FICT",
      "ru": "ФИКТ",
      "uk": "ФІКТ",
    },
    "ФЕМ": {
      "en": "FEM",
      "ru": "ФЭМ",
      "uk": "ФЕМ",
    },
    "fem": {
      "en": "FEM",
      "ru": "ФЭМ",
      "uk": "ФЕМ",
    },
    "ГЕФ": {
      "en": "MEF",
      "ru": "ГЭФ",
      "uk": "ГЕФ",
    },
    "mef": {
      "en": "MEF",
      "ru": "ГЭФ",
      "uk": "ГЕФ",
    },
    "ФОФ": {
      "en": "FAF",
      "ru": "ФУФ",
      "uk": "ФОФ",
    },
    "faf": {
      "en": "FAF",
      "ru": "ФУФ",
      "uk": "ФОФ",
    },
    "ФІМ": {
      "en": "FME",
      "ru": "ФИМ",
      "uk": "ФІМ",
    },
    "fme": {
      "en": "FME",
      "ru": "ФИМ",
      "uk": "ФІМ",
    },
    "facultiesGridTitle": {
      "en": "Choose a faculty",
      "ru": "Выберите факультет",
      "uk": "Обери факультет",
    },
    "noFacultiesStored": {
      "en": "There are no faculties yet. Connect to the Internet in order to load some.",
      "ru": "Информация о парах отсутствует. Подключитесь к Интернету для синхронизации.",
      "uk": "Інформація про пари відсутня. Підключіться до Інтернету для синхронізації.",
    },
    "selectGroupAndYear": {
      "en": "Choose your course and group",
      "ru": "Выберите курс и группу",
      "uk": "Оберіть курс та групу",
    },
    "yearSelectorPlaceholder": {
      "en": "Year",
      "ru": "Год",
      "uk": "Рік",
    },
    "groupSelectorPlaceholder": {
      "en": "Group",
      "ru": "Группа",
      "uk": "Група",
    },
    "groupSelectorLabel": {
      "en": "Group",
      "ru": "Группа",
      "uk": "Група",
    },
    "year": {
      "en": "year",
      "ru": "курс",
      "uk": "рік",
    },
    "Year_1m": {
      "en": "5 year",
      "ru": "5 курс",
      "uk": "5 курс",
    }
  };
}

class TextsDelegate extends LocalizationsDelegate<Texts> {
  const TextsDelegate();

  static final List<String> _supportedLocales = ["en", "ru", "uk"];

  @override
  bool isSupported(Locale locale) =>
      _supportedLocales.contains(locale.languageCode);

  @override
  Future<Texts> load(Locale locale) =>
      new Future<Texts>.sync(() {
        Texts.setCurrentLocale(locale);
        return new Texts(locale);
      });

  @override
  bool shouldReload(LocalizationsDelegate<Texts> old) => false;
}
