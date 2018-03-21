import '../../domain/faculty/Faculty.dart';

class FacultyInfo {
  String id;
  String name;
  String abbr;
  String image;

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "abbr": abbr,
      "image": image,
    };
  }

  FacultyInfo.fromMap(Map map) {
    id = map["id"].toString();
    name = map["name"];
    abbr = map["abbr"];
    image = map["image"];
  }

  FacultyInfo.fromFaculty(Faculty faculty) {
    assert(faculty != null);

    id = faculty.id;
    abbr = faculty.abbr;
    name = faculty.name;
    image = faculty.image;
  }

  Faculty toFaculty() {
    var result = new Faculty(name: name, abbr: abbr);
    result.id = id;
    result.image = image;
    return result;
  }
}
