import 'package:zstu/src/domain/faculty/Group.dart';
import '../teacher/Teacher.dart';
import 'PairType.dart';
import 'Timetable.dart';

class Pair {
  String name;

  Teacher teacher;

  List<Group> groups;

  String room;

  PairType type;

  Timetable time;

  DateTime customDate;
}