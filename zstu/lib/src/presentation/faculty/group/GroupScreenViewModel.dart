import 'dart:async';

import '../../../App.dart';
import '../../../domain/faculty/Year.dart';
import 'GroupViewModel.dart';

class GroupScreenViewModel {
  List<Year> years;

  List<GroupViewModel> groups;

  Future initialize() async {
    var app = new App();
    this.years = await app.faculties.getYears();
  }
}
