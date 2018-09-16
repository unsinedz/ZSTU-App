import 'dart:ui';

import 'package:zstu/src/core/locale/ITextProvider.dart';

class TextsUk implements ITextProvider {
  const TextsUk();

  @override
  Locale get locale => const Locale('uk', '');

  @override
  String getText(String key) {
    if (!_texts.containsKey(key)) return null;

    return _texts[key];
  }

  final Map<String, String> _texts = const {
    'facultiesTitle': 'Факультети',
    'scheduleTitle': 'Розклад',
    'myScheduleTitle': 'Мій розклад',
    'groupTitle': 'Група',
    'teachersTitle': 'Викладачі',
    'newsTitle': 'Новини',
    'learnPortalTitle': 'Освітній портал',
    'settingsTitle': 'Налаштування',
    'aboutTitle': 'Про програму',
    'ФІКТ': 'ФІКТ',
    'fict': 'ФІКТ',
    'ФЕМ': 'ФЕМ',
    'fem': 'ФЕМ',
    'ГЕФ': 'ГЕФ',
    'mef': 'ГЕФ',
    'ФОФ': 'ФОФ',
    'faf': 'ФОФ',
    'ФІМ': 'ФІМ',
    'fme': 'ФІМ',
    'appName': 'ЖДТУ',
    'mondayShort': 'Пн',
    'tuesdayShort': 'Вт',
    'wednesdayShort': 'Ср',
    'thursdayShort': 'Чт',
    'fridayShort': 'Пт',
    'saturdayShort': 'Сб',
    'sundayShort': 'Нд',
    'facultiesGridTitle': 'Оберіть факультет',
    'dataLoadError': 'Дані не будо отримано. Ви точно підключені до Інтернету?',
    'selectGroupAndYear': 'Оберіть курс та групу',
    'yearSelectorPlaceholder': 'Курс',
    'groupSelectorPlaceholder': 'Група',
    'groupSelectorLabel': 'Група',
    'selectYearFirst': 'Оберіть курс',
    'Year_1m': '5 курс',
    'year': 'курс',
    'findSchedule': 'Пошук пар',
    'scheduleDayOff': 'Сьогодні пар немає. Можете відпочити.',
    'featureNotAvailable': 'В розробці',
    'noConnection': 'Відсутнє підключення до мережі',
    'somethingWentWrong': 'Упс, щось пішло не так...',
    'Setting_General': 'Загальні',
    'Setting_Support': 'Підтримка',
    'Setting_Notification': 'Повідомлення',
    'Setting_General_applicationLanguage': 'Мова додатку',
    'Setting_Support_AskQuestion': 'Задати питання',
    'Setting_Support_SuggestFeature': 'Запропонувати покращення',
    'Setting_Support_NoticedProblem': 'Помітили помилку?',
    'Setting_Notification_scheduleChange': 'Зміни в розкладі',
    'Locale_en': 'English',
    'Locale_ru': 'Русский',
    'Locale_uk': 'Українська',
  };
}
