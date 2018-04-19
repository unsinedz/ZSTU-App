import '../../domain/faculty/Group.dart';
import '../common/IPersistableEntity.dart';

class GroupInfo implements IPersistableEntity {
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

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "yearId": yearId,
      "facultyId": facultyId,
    };
  }
}
