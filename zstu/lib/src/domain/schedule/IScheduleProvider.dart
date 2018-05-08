import 'dart:async';

import 'Schedule.dart';
import 'ScheduleLoadOptions.dart';

abstract class IScheduleProvider {
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions);
}