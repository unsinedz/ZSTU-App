import 'package:flutter/material.dart';
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
