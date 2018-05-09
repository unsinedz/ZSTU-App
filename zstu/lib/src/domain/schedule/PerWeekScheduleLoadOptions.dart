import '../faculty/Group.dart';
import 'ScheduleLoadOptions.dart';

class PerWeekScheduleLoadOptions extends ScheduleLoadOptions {
  PerWeekScheduleLoadOptions({this.group, this.weekNo});

  int weekNo;

  @override
  Group group;

  @override
  Map<String, String> toMap() {
    var map = super.toMap();
    map["week"] = weekNo.toString();
    return map;
  }
}
