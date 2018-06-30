import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zstu/src/core/locale/ILocaleProvider.dart';

class Texts {
  Texts(this._localeProvider);

  static Texts of(BuildContext context) {
    return Localizations.of<Texts>(context, Texts);
  }

  final ILocaleProvider _localeProvider;
  Locale get _locale => _localeProvider.getApplicationLocale();

  String get appName => _texts["appName"][_locale.languageCode];

  String get scheduleTitle => _screens["scheduleTitle"][_locale.languageCode];
  String get myScheduleTitle =>
      _screens["myScheduleTitle"][_locale.languageCode];
  String get facultiesTitle => _screens["facultiesTitle"][_locale.languageCode];
  String get groupTitle => _screens["groupTitle"][_locale.languageCode];
  String get teachersTitle => _screens["teachersTitle"][_locale.languageCode];
  String get newsTitle => _screens["newsTitle"][_locale.languageCode];
  String get learnPortalTitle =>
      _screens["learnPortalTitle"][_locale.languageCode];
  String get settingsTitle => _screens["settingsTitle"][_locale.languageCode];
  String get aboutTitle => _screens["aboutTitle"][_locale.languageCode];

  /*
    Screen texts
   */
  static final Map<String, Map<String, String>> _screens = {
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
    "myScheduleTitle": {
      "en": "My schedule",
      "ru": "Мое расписание",
      "uk": "Мій розклад",
    },
    "groupTitle": {
      "en": "Group",
      "ru": "Группа",
      "uk": "Група",
    },
    "teachersTitle": {
      "en": "Teachers",
      "ru": "Преподаватели",
      "uk": "Викладачі",
    },
    "newsTitle": {
      "en": "News",
      "ru": "Новости",
      "uk": "Новини",
    },
    "learnPortalTitle": {
      "en": "Learn portal",
      "ru": "Образовательный портал",
      "uk": "Освітній портал",
    },
    "settingsTitle": {
      "en": "Settings",
      "ru": "Настройки",
      "uk": "Налаштування",
    },
    "aboutTitle": {
      "en": "About",
      "ru": "О программе",
      "uk": "Про програму",
    },
  };

  String get fict => _faculties["fict"][_locale.languageCode];
  String get fem => _faculties["fem"][_locale.languageCode];
  String get mef => _faculties["mef"][_locale.languageCode];
  String get faf => _faculties["faf"][_locale.languageCode];
  String get fme => _faculties["fme"][_locale.languageCode];

  /*
    Faculty texts
   */
  static final Map<String, Map<String, String>> _faculties = {
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
  };

  String get facultiesGridTitle =>
      _texts["facultiesGridTitle"][_locale.languageCode];

  String get mondayShort => _texts["mondayShort"][_locale.languageCode];
  String get tuesdayShort => _texts["tuesdayShort"][_locale.languageCode];
  String get wednesdayShort => _texts["wednesdayShort"][_locale.languageCode];
  String get thursdayShort => _texts["thursdayShort"][_locale.languageCode];
  String get fridayShort => _texts["fridayShort"][_locale.languageCode];
  String get saturdayShort => _texts["saturdayShort"][_locale.languageCode];
  String get sundayShort => _texts["sundayShort"][_locale.languageCode];

  String get selectGroupAndYear =>
      _texts["selectGroupAndYear"][_locale.languageCode];
  String get yearSelectorPlaceholder =>
      _texts["yearSelectorPlaceholder"][_locale.languageCode];
  String get yearSelectorLabel =>
      _texts["yearSelectorPlaceholder"][_locale.languageCode];
  String get groupSelectorPlaceholder =>
      _texts["groupSelectorPlaceholder"][_locale.languageCode];
  String get groupSelectorLabel =>
      _texts["groupSelectorLabel"][_locale.languageCode];
  String get selectYearFirst => _texts["selectYearFirst"][_locale.languageCode];

  String get year => _texts["year"][_locale.languageCode];

  String get findSchedule => _texts["findSchedule"][_locale.languageCode];

  String get scheduleDayOff => _texts["scheduleDayOff"][_locale.languageCode];

  String get featureNotAvailable =>
      _texts["featureNotAvailable"][_locale.languageCode];
  String get noConnection => _texts["noConnection"][_locale.languageCode];

  String get dataLoadError => _texts["dataLoadError"][_locale.languageCode];

  /*
    General texts
   */
  static final Map<String, Map<String, String>> _texts = {
    "appName": {
      "en": "ZSTU",
      "ru": "ЖГТУ",
      "uk": "ЖДТУ",
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
    "facultiesGridTitle": {
      "en": "Choose a faculty",
      "ru": "Выберите факультет",
      "uk": "Обери факультет",
    },
    "dataLoadError": {
      "en":
          "Data was not loaded. Are you sure you have an active Internet connection?",
      "ru": "Данные не были получены. Вы точно подключены к Интернету?",
      "uk": "Дані не будо отримано. Ви точно підключені до Інтернету?",
    },
    "selectGroupAndYear": {
      "en": "Choose your course and group",
      "ru": "Выберите курс и группу",
      "uk": "Оберіть курс та групу",
    },
    "yearSelectorPlaceholder": {
      "en": "Year",
      "ru": "Курс",
      "uk": "Курс",
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
    "selectYearFirst": {
      "en": "Select year first",
      "ru": "Выбирите курс",
      "uk": "Оберіть курс",
    },
    "Year_1m": {
      "en": "5 year",
      "ru": "5 курс",
      "uk": "5 курс",
    },
    "year": {
      "en": "year",
      "ru": "курс",
      "uk": "курс",
    },
    "findSchedule": {
      "en": "Find schedule",
      "ru": "Поиск пар",
      "uk": "Пошук пар",
    },
    "scheduleDayOff": {
      "en": "There are no pairs today. You may rest.",
      "ru": "Сегодня пар нет. Можете отдохнуть.",
      "uk": "Сьогодні пар немає. Можете відпочити.",
    },
    "featureNotAvailable": {
      "en": "Feature is in development",
      "ru": "В разработке",
      "uk": "В розробці",
    },
    "noConnection": {
      "en": "No network connection",
      "ru": "Отсутствует подключение к сети",
      "uk": "Відсутнє підключення до мережі",
    },
  };

  static String getText(String key, String languageCode,
      [String defaultValue]) {
    assert(key != null);
    assert(languageCode != null);

    var vals = _screens[key] ?? _faculties[key] ?? _texts[key];
    if (vals == null) return defaultValue;

    return vals[languageCode] ?? defaultValue;
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
