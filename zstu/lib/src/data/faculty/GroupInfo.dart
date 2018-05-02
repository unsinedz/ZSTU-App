import '../../domain/faculty/Group.dart';
import '../common/IPersistableEntity.dart';

class GroupInfo implements IPersistableEntity {
  String id;
  String name;
  String yearId;
  String facultyId;

  GroupInfo.fromMap(Map<String, dynamic> map) {
    if (map == null)
      throw new ArgumentError("Map is null.");

    id = map["id"].toString();
    name = map["name"];
    yearId = map["yearId"].toString();
    facultyId = map["facultyId"].toString();
  }

  GroupInfo.fromGroup(Group group) {
    if (group == null)
      throw new ArgumentError("Group is null.");

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
