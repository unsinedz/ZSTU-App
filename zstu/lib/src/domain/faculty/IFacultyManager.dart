import 'dart:async';
import 'Chair.dart';
import 'ChairLoadOptions.dart';
import 'Faculty.dart';
import 'Group.dart';
import 'GroupLoadOptions.dart';
import 'Year.dart';

abstract class IFacultyManager {
  Future<List<Faculty>> getFaculties();

  Future<List<Chair>> getChairs(ChairLoadOptions loadOptions);

  Future<List<Year>> getYears();

  Future<List<Group>> getGroups(GroupLoadOptions loadOptions);
}