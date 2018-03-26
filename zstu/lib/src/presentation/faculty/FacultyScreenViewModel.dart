import 'dart:async';

import '../../App.dart';
import 'FacultyViewModel.dart';

class FacultyScreenViewModel {
  List<FacultyViewModel> faculties;

  Future loadFaculties() async {
    var app = new App();
    faculties = (await app.faculties.getFaculties())
        .map((x) => new FacultyViewModel.fromFaculty(x))
        .toList();
  }
}
