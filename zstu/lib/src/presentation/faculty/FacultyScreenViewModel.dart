import 'dart:async';

import '../../App.dart';
import 'FacultyViewModel.dart';

class FacultyScreenViewModel {
  List<FacultyViewModel> faculties;

  Future initialize() async {
    var app = new App();
    faculties = (await app.faculties.getFaculties())
        .map((x) => new FacultyViewModel.fromFaculty(x))
        .toList();
  }
}
