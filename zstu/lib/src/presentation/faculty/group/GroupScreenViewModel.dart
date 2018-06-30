import 'dart:async';
import 'dart:ui';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import '../../../App.dart';
import '../../../domain/faculty/Faculty.dart';
import '../../../domain/faculty/GroupLoadOptions.dart';
import '../../../domain/faculty/Year.dart';
import '../../common/BaseViewModel.dart';
import 'YearViewModel.dart';
import 'GroupViewModel.dart';

class GroupScreenViewModel extends BaseViewModel implements ILocaleSensitive {
  List<YearViewModel> years;

  List<GroupViewModel> groups;

  @override
  Future initialize() async {
    this.years = (await new App().faculties.getYears())
        .map((x) => new YearViewModel.fromYear(x))
        .toList();

    await super.initialize();
  }

  Future loadGroups(Faculty faculty, Year year) async {
    var entities = await new App()
        .faculties
        .getGroups(new GroupLoadOptions(faculty, year));
    groups = entities.map((x) => new GroupViewModel.fromGroup(x)).toList();
  }

  @override
  void initializeForLocale(Locale locale) {
    years.forEach((x) => x.initializeForLocale(locale));
  }
}
