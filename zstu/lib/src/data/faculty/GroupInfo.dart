import '../../domain/faculty/Group.dart';

class GroupInfo {
  String id;
  String name;
  String yearId;
  String facultyId;

  GroupInfo.fromMap(Map<String, dynamic> map) {
    assert(map != null);

    id = map["id"].toString();
    name = map["name"];
    yearId = map["yearId"];
    facultyId = map["facultyId"];
  }

  GroupInfo.fromGroup(Group group) {
    assert(group != null);

    id = group.id;
    name = group.name;
    yearId = group.year.id;
    facultyId = group.faculty.id;
  }

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "yearId": yearId,
      "facultyId": facultyId,
    };
  }
}
