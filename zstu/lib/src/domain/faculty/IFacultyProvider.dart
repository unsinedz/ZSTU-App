import 'dart:async';

import '../../data/common/provider/IProvider.dart';
import 'Chair.dart';
import 'ChairLoadOptions.dart';
import 'Faculty.dart';
import 'Group.dart';
import 'GroupLoadOptions.dart';
import 'Year.dart';

abstract class IFacultyProvider extends IProvider<Faculty> {
  Future<List<Year>> getYears();
  Future insertAllYears(List<Year> years);

  Future<List<Group>> getGroups(GroupLoadOptions loadOptions);
  Future insertAllGroups(List<Group> groups);

  Future<List<Chair>> getChairs(ChairLoadOptions loadOptions);
  Future insertAllChairs(List<Chair> chairs);
}
