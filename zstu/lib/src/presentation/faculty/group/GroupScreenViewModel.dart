import 'dart:async';
import 'dart:ui';

import '../../../App.dart';
import '../../../domain/common/text/ITextSensitive.dart';
import '../../common/BaseViewModel.dart';
import 'YearViewModel.dart';
import 'GroupViewModel.dart';

class GroupScreenViewModel extends BaseViewModel implements ITextSensitive {
  List<YearViewModel> years;

  List<GroupViewModel> groups;

  @override
  Future initialize() async {
    var app = new App();
    this.years = (await app.faculties.getYears())
        .map((x) => new YearViewModel.fromYear(x))
        .toList();

    await super.initialize();
  }

  @override
  void translateTexts(Locale locale) {
    groups?.forEach((x) => x.translateTexts(locale));
    years.forEach((x) => x.translateTexts(locale));
  }
}
