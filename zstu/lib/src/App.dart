import 'package:zstu/src/core/event/EventBus.dart';
import 'package:zstu/src/core/locale/DefaultLocaleProvider.dart';
import 'package:zstu/src/core/locale/ILocaleProvider.dart';
import 'package:zstu/src/domain/common/serialization/ValueSerializerFactory.dart';
import 'data/DataModule.dart';
import 'domain/common/IAssetManager.dart';
import 'domain/common/process/IProcess.dart';
import 'domain/common/text/ITextProcessor.dart';
import 'domain/faculty/IFacultyManager.dart';
import 'domain/schedule/IScheduleManager.dart';
import 'domain/schedule/ScheduleSelectionProcess.dart';

class App {
  static App _instance;
  factory App() => _instance ?? (_instance = new App._());

  App._();

  EventBus get eventBus => _IOC.provideEventBus();

  IFacultyManager get faculties => _IOC.provideFaculty();

  IScheduleManager get schedule => _IOC.provideSchedule();

  IAssetManager get assets => _IOC.provideAsset();

  ITextProcessor get textProcessor => _IOC.provideTextProcessor();

  ILocaleProvider get locale => _IOC.provideLocale();

  ValueSerializerFactory get valueSerializers => ValueSerializerFactory.instance;

  Processes get processes => Processes._instance = Processes._instance ?? new Processes._();
}

class Processes {
  Processes._();

  static Processes _instance;

  List<IProcess> _processes = <IProcess>[];

  ScheduleSelectionProcess get scheduleSelection => _getOrAdd(new ScheduleSelectionProcess());

  T _getOrAdd<T extends IProcess>(T instanceToAdd) {
    if (instanceToAdd == null)
      throw new ArgumentError("Instance is null.");

    var processes = _processes.where((dynamic x) => (x as T) != null);
    if (processes.length == 0) {
      _processes.add(instanceToAdd);
    }

    return processes.first as T;
  }
}

class _IOC {
  static EventBus provideEventBus() {
    return EventBus.instance;
  }

  static ILocaleProvider provideLocale() {
    return DefaultLocaleProvider.instance;
  }

  static IFacultyManager provideFaculty() {
    return DataModule.provideFaculty();
  }

  static IScheduleManager provideSchedule() {
    return DataModule.provideSchedule();
  }

  static IAssetManager provideAsset() {
    return DataModule.provideAsset();
  }

  static ITextProcessor provideTextProcessor() {
    return DataModule.provideTextProcessor(provideLocale());
  }
}
