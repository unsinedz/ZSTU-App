import 'dart:async';
import 'package:flutter/foundation.dart';

typedef Future<T> ValueProvider<T>();
typedef T SyncValueProvider<T>();

class Lazy<T> {
  Lazy({@required this.valueProvider}) : assert(valueProvider != null);

  final SyncValueProvider<T> valueProvider;

  T _value;
  T getValue() => _value = _value ?? valueProvider();
}
