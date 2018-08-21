import 'package:flutter/widgets.dart';

abstract class IDynamicallyChangeableEditor<T> {
  void addOnChange(ValueChanged<T> onChange);
}