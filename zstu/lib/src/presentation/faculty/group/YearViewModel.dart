import 'dart:ui';

import '../../../domain/common/text/ITextSensitive.dart';
import '../../../domain/faculty/Year.dart';
import '../../../resources/Texts.dart';
import '../../common/BaseViewModel.dart';

class YearViewModel extends BaseViewModel implements ITextSensitive {
  YearViewModel.fromYear(Year year) {
    assert(year != null);

    id = year.id;
    name = year.name;
  }

  static const String _YearLocalizationKeyPrefix = "Year_";

  String id;

  String name;

  @override
  void translateTexts(Locale locale) {
    name = Texts.getText(_getTextKey(name), locale.languageCode, '$name ${Texts.getText("year", locale.languageCode)}');
  }

  String _getTextKey(String simpleText) {
    assert(simpleText != null);

    return _YearLocalizationKeyPrefix + simpleText;
  }
}
