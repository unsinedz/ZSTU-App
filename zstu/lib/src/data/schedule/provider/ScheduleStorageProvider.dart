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
  Future<Schedule> getById(String id) async {
    throw new UnimplementedError();
  }

  @override
  Future<List<Schedule>> getList() {
    throw new UnimplementedError();
  }

  @override
  Future<Schedule> getSchedule(ScheduleLoadOptions loadOptions) async {
    throw new UnimplementedError();
  }

  @override
  Future insert(Schedule obj) {
    throw new UnimplementedError();
  }

  @override
  Future insertAll(List<Schedule> objList) {
    throw new UnimplementedError();
  }
}
