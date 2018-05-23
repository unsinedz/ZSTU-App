import '../../domain/faculty/Faculty.dart';
import '../../domain/faculty/Group.dart';
import '../../domain/faculty/Year.dart';
import '../common/IPersistableEntity.dart';

class GroupInfo implements IPersistableEntity {
  GroupInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) throw new ArgumentError("Map is null.");

    _group = new Group(
      map["id"].toString(),
      map["name"],
      new Year(id: map["yearId"].toString()),
      new Faculty(id: map["facultyId"].toString()),
    );
  }

  GroupInfo.fromGroup(Group group) {
    if (group == null) throw new ArgumentError("Group is null.");
    this._group = group;
  }

  Group _group;

  String get id => _group.id;
  String get name => _group.name;
  String get yearId => _group.year.id;
  String get facultyId => _group.faculty.id;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "yearId": yearId,
      "facultyId": facultyId,
    };
  }
}

// TODO: unit-tests for -Info entities