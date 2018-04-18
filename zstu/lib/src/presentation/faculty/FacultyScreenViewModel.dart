import 'dart:async';
import 'dart:ui';

import '../../App.dart';
import '../../domain/common/text/ITextSensitive.dart';
import '../common/BaseViewModel.dart';
import 'FacultyViewModel.dart';

class FacultyScreenViewModel extends BaseViewModel implements ITextSensitive {
  List<FacultyViewModel> faculties;

  Future initialize() async {
    var app = new App();
    faculties = (await app.faculties.getFaculties())
        .map((x) => new FacultyViewModel.fromFaculty(x))
        .toList();

    await super.initialize();
  }

  @override
  void translateTexts(Locale locale) {
    faculties.forEach((x) => x.translateTexts(locale));
  }
}
