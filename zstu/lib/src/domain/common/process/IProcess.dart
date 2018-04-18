abstract class IProcess<TResult> {
  void clear();
  bool canBeExecuted();
  TResult execute();
}
