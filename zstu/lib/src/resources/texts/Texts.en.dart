import 'dart:ui';

import 'package:zstu/src/core/locale/ITextProvider.dart';

class TextsEn implements ITextProvider {
  const TextsEn();

  @override
  Locale get locale => const Locale('en', '');

  @override
  String getText(String key) {
    if (!_texts.containsKey(key)) return null;

    return _texts[key];
  }

  final Map<String, String> _texts = const {
    'facultiesTitle': 'Faculties',
    'scheduleTitle': 'Schedule',
    'myScheduleTitle': 'My schedule',
    'groupTitle': 'Group',
    'teachersTitle': 'Teachers',
    'newsTitle': 'News',
    'learnPortalTitle': 'Learn portal',
    'settingsTitle': 'Settings',
    'aboutTitle': 'About',
    'ФІКТ': 'FICT',
    'fict': 'FICT',
    'ФЕМ': 'FEM',
    'fem': 'FEM',
    'ГЕФ': 'MEF',
    'mef': 'MEF',
    'ФОФ': 'FAF',
    'faf': 'FAF',
    'ФІМ': 'FME',
    'fme': 'FME',
    'appName': 'ZSTU',
    'mondayShort': 'Mon',
    'tuesdayShort': 'Tue',
    'wednesdayShort': 'Wed',
    'thursdayShort': 'Thu',
    'fridayShort': 'Fri',
    'saturdayShort': 'Sat',
    'sundayShort': 'Sun',
    'facultiesGridTitle': 'Choose a faculty',
    'dataLoadError':
        'Data was not loaded. Are you sure you have an active Internet connection?',
    'selectGroupAndYear': 'Choose your course and group',
    'yearSelectorPlaceholder': 'Year',
    'groupSelectorPlaceholder': 'Group',
    'groupSelectorLabel': 'Group',
    'selectYearFirst': 'Select year first',
    'Year_1m': '5 year',
    'year': 'year',
    'findSchedule': 'Find schedule',
    'scheduleDayOff': 'There are no pairs today. You may rest.',
    'featureNotAvailable': 'Feature is in development',
    'noConnection': 'No network connection',
    'somethingWentWrong': 'Oops, something went wrong...',
    'Setting_General': 'General',
    'Setting_Support': 'Support',
    'Setting_Notification': 'Notifications',
    'Setting_General_applicationLanguage': 'Application language',
    'Setting_Support_AskQuestion': 'Ask a question',
    'Setting_Support_SuggestFeature': 'Suggest a feature',
    'Setting_Support_NoticedProblem': 'Noticed a problem?',
    'Setting_Notification_scheduleChange': 'Schedule changes',
    'Locale_en': 'English',
    'Locale_ru': 'Русский',
    'Locale_uk': 'Українська',
  };
}
