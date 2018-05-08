import 'dart:async';

import '../../domain/schedule/IScheduleManager.dart';
import '../../domain/schedule/IScheduleProvider.dart';
import '../../domain/schedule/ScheduleLoadOptions.dart';
import '../../domain/schedule/Schedule.dart';

class ScheduleManager implements IScheduleManager {
  ScheduleManager(this._storageProvider, this._networkProvider);

  IScheduleProvider _storageProvider;
  IScheduleProvider _networkProvider;

  @override
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions) {
    return _networkProvider.getSchedule(loadOptions);
  }
}