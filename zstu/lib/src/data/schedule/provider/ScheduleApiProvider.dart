import 'dart:async';

import '../../../domain/schedule/IScheduleProvider.dart';
import '../../../domain/schedule/Pair.dart';
import '../../../domain/schedule/ScheduleLoadOptions.dart';
import '../../../domain/schedule/Schedule.dart';
import '../../Constants.dart';
import '../../common/provider/NetworkProviderBase.dart';
import '../PairInfo.dart';

class ScheduleApiProvider extends NetworkProviderBase
    implements IScheduleProvider {
  ScheduleApiProvider(baseProvider) : super(Constants.API_URI, baseProvider);

  static const Map<String, String> _paths = const {
    "schedule": "/schedule",
  };

  static const Map<String, int> _weekDays = {
    "Понеділок": 1,
    "Вівторок": 2,
    "Середа": 3,
    "Четвер": 4,
    "П'ятниця": 5,
    "Субота": 6,
    "Неділя": 7,
  };

  @override
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions) async {
    var pairs = await getEntities(_paths["schedule"], loadOptions.toMap(),
        (x) => new PairInfo.fromMap(x).toPair());
    var dailyPairs = <int, List<Pair>>{};
    pairs.forEach((x) {
      int dayNo = _weekDays[x.day] ?? 0;
      (dailyPairs[dayNo] = dailyPairs[dayNo] ?? <Pair>[]).add(x);
    });
    return new Schedule(
      weekNo: loadOptions.weekNo,
      weekPairs: dailyPairs,
    );
  }
}
