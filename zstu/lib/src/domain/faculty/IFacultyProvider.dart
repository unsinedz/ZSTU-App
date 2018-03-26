import 'Group.dart';
import 'GroupLoadOptions.dart';

abstract class IFacultyProvider {
  List<int> getYears();

  List<Group> getGroups(GroupLoadOptions loadOptions);
}