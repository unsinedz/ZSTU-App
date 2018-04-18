import 'IProcess.dart';

abstract class IStep<TProcess extends IProcess> {
  bool canBeExecuted(TProcess process);
}