import 'dart:ui';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import '../../domain/faculty/Faculty.dart';
import '../../resources/Texts.dart';

class FacultyViewModel implements ILocaleSensitive {
  FacultyViewModel.fromFaculty(Faculty faculty) {
    if (faculty == null) throw new ArgumentError("Faculty is null.");

    this._faculty = faculty;
  }

  Faculty toFaculty() {
    return _faculty;
  }

  Faculty _faculty;

  String get id => _faculty.id;

  String _abbr;
  String get abbr => _abbr = _abbr ?? _faculty.abbr;
  set abbr(String newAbbr) => this._abbr = newAbbr;

  String get image => _faculty.image;

  @override
  void initializeForLocale(Locale locale) {
    abbr = Texts.getText(abbr, locale.languageCode, abbr);
  }
}
