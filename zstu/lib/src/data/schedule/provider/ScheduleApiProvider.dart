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
    "Понеділок": DateTime.monday,
    "Вівторок": DateTime.tuesday,
    "Середа": DateTime.wednesday,
    "Четвер": DateTime.thursday,
    "П'ятниця": DateTime.friday,
    "Субота": DateTime.saturday,
    "Неділя": DateTime.sunday,
  };

  @override
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions) async {
    var pairs = await new Stream.fromIterable(await getEntities(
        _paths["schedule"],
        loadOptions.toMap(),
        (x) => new PairInfo.fromMap(x).toPair())).distinct((x, y) {
      print('distinct');
      return x.day == y.day &&
          x.name == y.name &&
          x.teacher == y.teacher &&
          x.time == y.time;
    }).toList();
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
