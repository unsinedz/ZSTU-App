import '../../domain/faculty/Faculty.dart';
import '../common/IPersistableEntity.dart';

class FacultyInfo implements IPersistableEntity {
  String id;
  String name;
  String abbr;
  String image;

  Map<String, dynamic> toMap() {
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
}
