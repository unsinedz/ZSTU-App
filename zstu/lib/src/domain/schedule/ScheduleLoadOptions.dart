import '../faculty/Group.dart';

abstract class ScheduleLoadOptions {
  Group group;

  int weekNo;

  Map<String, String> toMap() {
    return {
      "group": group.id,
    };
  }
}