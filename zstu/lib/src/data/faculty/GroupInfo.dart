import '../../domain/faculty/Group.dart';
import 'FacultyInfo.dart';
import 'YearInfo.dart';

class GroupInfo {
  String id;
  String name;
  YearInfo year;
  FacultyInfo faculty;

  GroupInfo.fromMap(Map<String, dynamic> map) {
    assert(map != null);

    id = map["id"].toString();
    name = map["name"];
    year = map["year"];
    faculty = map["faculty"];
  }

  GroupInfo.fromGroup(Group group) {
    assert(group != null);

    id = group.id;
    name = group.name;
    year = new YearInfo.fromYear(group.year);
    faculty = new FacultyInfo.fromFaculty(group.faculty);
  }

  Group toGroup() {
    return new Group(name, year.toYear(), faculty.toFaculty());
  }

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "year": year,
      "faculty": faculty,
    };
  }
}
