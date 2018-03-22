import '../../domain/faculty/Faculty.dart';

class FacultyViewModel {
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
}
