import '../../domain/faculty/Faculty.dart';
import '../common/IPersistableEntity.dart';

class FacultyInfo implements IPersistableEntity {
  FacultyInfo.fromMap(Map map) {
    _faculty = new Faculty(
      id: map["id"].toString(),
      name: map["name"],
      abbr: map["abbr"],
      image: map["image"],
    );
  }

  FacultyInfo.fromFaculty(Faculty faculty) {
    if (faculty == null) throw new ArgumentError("Faculty is null.");
    this._faculty = faculty;
  }

  Faculty _faculty;

  String get id => _faculty.id;
  String get name => _faculty.name;
  String get abbr => _faculty.abbr;
  String get image => _faculty.image;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "abbr": abbr,
      "image": image,
    };
  }
}
