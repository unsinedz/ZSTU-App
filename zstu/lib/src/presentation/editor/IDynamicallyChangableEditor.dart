import 'package:flutter/widgets.dart';

abstract class IDynamicallyChangableEditor<T> {
  void addOnChange(ValueChanged<T> onChange);
}