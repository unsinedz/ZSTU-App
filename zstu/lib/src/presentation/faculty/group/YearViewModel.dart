import 'dart:ui';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import '../../../domain/faculty/Year.dart';
import '../../../resources/Texts.dart';
import '../../common/BaseViewModel.dart';

class YearViewModel extends BaseViewModel implements ILocaleSensitive {
  YearViewModel.fromYear(Year year) {
    if (year == null) throw new ArgumentError("Year is null.");

    _year = year;
  }

  static const String _YearLocalizationKeyPrefix = "Year_";

  Year _year;

  String get id => _year.id;

  String _name;
  String get name => _name = _name ?? _year.name;
  set name(String newName) => this._name = newName;

  Year toYear() {
    return _year;
  }

  String _getTextKey(String simpleText) {
    assert(simpleText != null);

    return _YearLocalizationKeyPrefix + simpleText;
  }

  @override
  void initializeForLocale(Locale locale) {
    name = Texts.getText(_getTextKey(name), locale.languageCode,
        '$name ${Texts.getText("year", locale.languageCode)}');
  }
}
