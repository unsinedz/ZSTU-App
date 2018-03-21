import 'dart:async';
import 'Chair.dart';
import 'Faculty.dart';
import 'Group.dart';
import 'GroupLoadOptions.dart';

abstract class IFacultyManager {
  Future<List<Faculty>> getFaculties();

  List<Chair> getChairs();

  List<int> getYears();

  List<Group> getGroups(GroupLoadOptions loadOptions);
}