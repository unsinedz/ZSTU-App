import 'dart:ui';

import '../../domain/common/text/ITextSensitive.dart';
import '../../domain/faculty/Faculty.dart';
import '../../resources/Texts.dart';

class FacultyViewModel implements ITextSensitive {
  FacultyViewModel(this.id, this.abbr, this.image);

  FacultyViewModel.fromFaculty(Faculty faculty) {
    assert(faculty != null);

    id = faculty.id;
    abbr = faculty.abbr;
    image = faculty.image;
  }

  String id;

  String abbr;

  String image;

  @override
  void translateTexts(Locale locale) {
    abbr = Texts.getText(abbr, locale.languageCode, abbr);
  }
}
