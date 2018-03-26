import 'dart:async';
import 'Chair.dart';
import 'Faculty.dart';
import 'Group.dart';
import 'GroupLoadOptions.dart';
import 'Year.dart';

abstract class IFacultyManager {
  Future<List<Faculty>> getFaculties();

  Future<List<Chair>> getChairs();

  Future<List<Year>> getYears();

  Future<List<Group>> getGroups(GroupLoadOptions loadOptions);
}