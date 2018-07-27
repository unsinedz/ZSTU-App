import 'dart:async';
import 'package:flutter/foundation.dart';

typedef Future<T> ValueProvider<T>();

class Lazy<T> {
  Lazy({@required this.valueProvider}) : assert(valueProvider != null);

  final ValueProvider<T> valueProvider;

  T _value;
  Future<T> getValue() async => _value = _value ?? await valueProvider();
}
