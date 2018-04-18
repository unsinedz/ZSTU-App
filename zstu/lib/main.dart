import 'dart:async';

import 'package:flutter/material.dart';
import 'src/App.dart';
import 'src/presentation/schedule/ScheduleScreen.dart';
import 'src/presentation/faculty/FacultyScreen.dart';
import 'src/resources/texts.dart';
import 'src/data/DataModule.dart';
import 'src/resources/Colors.dart';

void main() async {
  await DataModule.configure();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ZSTU",
      localizationsDelegates: [
        const InitLocalizationsDelegate(),
        const TextsDelegate(),
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ru"),
        const Locale("uk"),
      ],
      theme: new ThemeData(
        primaryColor: AppColors.Primary,
      ),
      home: new FacultiesScreen(),
      routes: <String, WidgetBuilder>{
        "/schedule": (ctx) => new ScheduleScreen(),
      },
    );
  }
}

class InitLocalizationsDelegate extends LocalizationsDelegate {
  const InitLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future load(Locale locale) =>
      new Future.sync(() => new App().textProcessor.initialize(locale));

  @override
  bool shouldReload(LocalizationsDelegate old) => true;
}
