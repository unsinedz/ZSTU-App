import '../common/process/IProcess.dart';
import '../common/process/IStep.dart';
import '../faculty/Faculty.dart';
import '../faculty/Group.dart';
import 'Schedule.dart';

class ScheduleSelectionProcess implements IProcess<Schedule> {
  ScheduleSelectionProcess([this.faculty, this.group]);

  Faculty faculty;
  Group group;

  bool canExecuteStep(IStep<ScheduleSelectionProcess> step) {
    return step?.canBeExecuted(this) ?? false;
  }

  @override
  bool canBeExecuted() {
    return faculty != null && group != null;
  }

  @override
  void clear() {
    faculty = null;
    group = null;
  }

  @override
  Schedule execute() {
    if (!canBeExecuted())
      throw new StateError("Process can not be executed.");

    throw new Exception("Not implemented.");
  }
}
