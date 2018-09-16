import 'dart:ui';

import 'package:zstu/src/core/locale/ITextProvider.dart';

class TextsRu implements ITextProvider {
  const TextsRu();

  @override
  Locale get locale => const Locale('ru', '');

  @override
  String getText(String key) {
    if (!_texts.containsKey(key)) return null;

    return _texts[key];
  }

  final Map<String, String> _texts = const {
    'facultiesTitle': 'Факультеты',
    'scheduleTitle': 'Расписание',
    'myScheduleTitle': 'Мое расписание',
    'groupTitle': 'Группа',
    'teachersTitle': 'Преподаватели',
    'newsTitle': 'Новости',
    'learnPortalTitle': 'Образовательный портал',
    'settingsTitle': 'Настройки',
    'aboutTitle': 'О программе',
    'ФІКТ': 'ФИКТ',
    'fict': 'ФИКТ',
    'ФЕМ': 'ФЭМ',
    'fem': 'ФЭМ',
    'ГЕФ': 'ГЭФ',
    'mef': 'ГЭФ',
    'ФОФ': 'ФУФ',
    'faf': 'ФУФ',
    'ФІМ': 'ФИМ',
    'fme': 'ФИМ',
    'appName': 'ЖГТУ',
    'mondayShort': 'Пн',
    'tuesdayShort': 'Вт',
    'wednesdayShort': 'Ср',
    'thursdayShort': 'Чт',
    'fridayShort': 'Пт',
    'saturdayShort': 'Сб',
    'sundayShort': 'Вс',
    'facultiesGridTitle': 'Выберите факультет',
    'dataLoadError':
        'Данные не были получены. Вы точно подключены к Интернету?',
    'selectGroupAndYear': 'Выберите курс и группу',
    'yearSelectorPlaceholder': 'Курс',
    'groupSelectorPlaceholder': 'Группа',
    'groupSelectorLabel': 'Группа',
    'selectYearFirst': 'Выбирите курс',
    'Year_1m': '5 курс',
    'year': 'курс',
    'findSchedule': 'Поиск пар',
    'scheduleDayOff': 'Сегодня пар нет. Можете отдохнуть.',
    'featureNotAvailable': 'В разработке',
    'noConnection': 'Отсутствует подключение к сети',
    'somethingWentWrong': 'Упс, что-то пошло не так...',
    'Setting_General': 'Общие',
    'Setting_Support': 'Поддержка',
    'Setting_Notification': 'Уведомления',
    'Setting_General_applicationLanguage': 'Язык приложения',
    'Setting_Support_AskQuestion': 'Задать вопрос',
    'Setting_Support_SuggestFeature': 'Предложить улучшение',
    'Setting_Support_NoticedProblem': 'Заметили ошибку?',
    'Setting_Notification_scheduleChange': 'Изменения в расписании',
    'Locale_en': 'English',
    'Locale_ru': 'Русский',
    'Locale_uk': 'Українська',
  };
}
