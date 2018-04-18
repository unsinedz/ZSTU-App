import 'dart:async';

import '../../App.dart';
import '../../domain/common/text/ITextSensitive.dart';

abstract class BaseViewModel {
  Future initialize() {
    return new Future.sync(() => _onLoad());
  }

  void _onLoad() {
    var textSensitiveModel = this as ITextSensitive;
    if (textSensitiveModel != null)
      new App().textProcessor.process(textSensitiveModel);
  }
}
