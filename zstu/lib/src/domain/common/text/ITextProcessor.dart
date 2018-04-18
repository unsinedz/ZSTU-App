import 'package:flutter/widgets.dart';

import 'ITextSensitive.dart';

abstract class ITextProcessor {
  void process(ITextSensitive object);
  void initialize(Locale locale);
}