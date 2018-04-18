import 'dart:ui';

import '../../domain/common/text/ITextSensitive.dart';
import '../../domain/faculty/Faculty.dart';
import '../../resources/Texts.dart';

class FacultyViewModel implements ITextSensitive {
  FacultyViewModel.fromFaculty(Faculty faculty) {
    assert(faculty != null);

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
  void translateTexts(Locale locale) {
    abbr = Texts.getText(abbr, locale.languageCode, abbr);
  }
}
