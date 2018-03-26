import 'dart:async';

import '../../../domain/faculty/GroupLoadOptions.dart';
import '../../common/provider/IProvider.dart';
import '../FacultyInfo.dart';
import '../YearInfo.dart';
import '../GroupInfo.dart';

abstract class IFacultyProvider extends IProvider<FacultyInfo> {
  Future<List<YearInfo>> getYears();
  Future insertAllYears(List<YearInfo> years);

  Future<List<GroupInfo>> getGroups(GroupLoadOptions loadOptions);
  Future insertAllGroups(List<GroupInfo> groups);
}
