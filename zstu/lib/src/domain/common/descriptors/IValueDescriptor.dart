abstract class IValueDescriptor<T> {
  List<T> getPossibleValues();
  bool canBeStringified();
  String stringify<T>(T value);
}
