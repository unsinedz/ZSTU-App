import 'dart:async';

import 'Schedule.dart';
import 'ScheduleLoadOptions.dart';

abstract class IScheduleManager {
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions);
}