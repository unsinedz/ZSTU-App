import 'dart:async';
import 'dart:ui';

import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';

import '../../App.dart';
import '../common/BaseViewModel.dart';
import 'FacultyViewModel.dart';

class FacultyScreenViewModel extends BaseViewModel implements ILocaleSensitive {
  List<FacultyViewModel> faculties;

  Future initialize() async {
    faculties = (await new App().faculties.getFaculties())
        .map((x) => new FacultyViewModel.fromFaculty(x))
        .toList();

    await super.initialize();
  }

  @override
  void initializeForLocale(Locale locale) {
    faculties.forEach((x) => x.initializeForLocale(locale));
  }
}
