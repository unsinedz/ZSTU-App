import '../../domain/faculty/Faculty.dart';

class FacultyViewModel {
  FacultyViewModel(this.abbr, this.image);

  FacultyViewModel.fromFaculty(Faculty faculty) {
    assert(faculty != null);

    abbr = faculty.abbr;
    image = faculty.image;
  }

  String abbr;

  String image;
}
