import 'dart:async';

import '../../App.dart';
import '../../domain/schedule/Pair.dart';
import '../../domain/schedule/Schedule.dart';
import '../../domain/schedule/ScheduleLoadOptions.dart';
import '../common/BaseViewModel.dart';
import 'PairViewModel.dart';

class ScheduleViewModel extends BaseViewModel {
  ScheduleViewModel();
  ScheduleViewModel.fromSchedule(this._schedule) : assert(_schedule != null);

  Schedule _schedule;

  int get weekNo => _schedule.weekNo;

  List<PairViewModel> getPairs(int day) {
    return (_schedule.weekPairs[day] ?? <Pair>[])
        .map((x) => new PairViewModel.fromPair(x))
        .toList();
  }

  Future loadSchedule(ScheduleLoadOptions options) async {
    _schedule = await new App().schedule.getSchedule(options);
  }
}
