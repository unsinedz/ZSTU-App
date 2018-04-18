import 'package:flutter/widgets.dart';

import '../../domain/common/text/ITextProcessor.dart';
import '../../domain/common/text/ITextSensitive.dart';

class TextProcessor implements ITextProcessor {
  Locale _locale;

  void initialize(Locale locale) => _locale = locale;

  @override
  void process(ITextSensitive object) {
    assert(object != null);
    object.translateTexts(_locale);
  }
}