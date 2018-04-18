import 'data/DataModule.dart';
import 'domain/common/IAssetManager.dart';
import 'domain/common/text/ITextProcessor.dart';
import 'domain/faculty/IFacultyManager.dart';
import 'domain/schedule/IScheduleManager.dart';
import 'domain/teacher/ITeacherManager.dart';

class App {
  static App _instance;
  factory App() => _instance ?? (_instance = new App._());

  App._();

  IFacultyManager get faculties => _IOC.provideFaculty();

  ITeacherManager get teachers => _IOC.provideTeacher();

  IScheduleManager get schedule => _IOC.provideSchedule();

  IAssetManager get assets => _IOC.provideAsset();

  ITextProcessor get textProcessor => _IOC.provideTextProcessor();
}

class _IOC {

  static IFacultyManager provideFaculty() {
    return DataModule.provideFaculty();
  }

  static ITeacherManager provideTeacher() {
    throw new UnimplementedError("Not implemented.");
  }

  static IScheduleManager provideSchedule() {
    throw new UnimplementedError("Not implemented.");
  }

  static IAssetManager provideAsset() {
    return DataModule.provideAsset();
  }

  static provideTextProcessor() {
    return DataModule.provideTextProcessor();
  }
}
