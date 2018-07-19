import 'dart:async';
import '../../../domain/schedule/IScheduleProvider.dart';
import '../../../domain/schedule/ScheduleLoadOptions.dart';
import '../../../domain/schedule/Schedule.dart';
import '../../../domain/Constants.dart';
import '../../common/provider/GeneralStorageProvider.dart';

class ScheduleStorageProvider implements IScheduleProvider {
  ScheduleStorageProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  static final String pairTableName = Constants.PairTableName;

  @override
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions) {
    throw new UnimplementedError();
  }
}
