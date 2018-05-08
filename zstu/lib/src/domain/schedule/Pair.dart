import 'package:zstu/src/domain/faculty/Group.dart';

class Pair {
  Pair({
    this.id,
    this.name,
    this.teacher,
    this.groups,
    this.room,
    this.type,
    this.day,
    this.time,
  });

  String id;

  String name;

  String teacher;

  List<Group> groups;

  String room;

  String type;

  String day;

  String time;
}
