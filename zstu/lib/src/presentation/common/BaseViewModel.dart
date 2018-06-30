import 'dart:async';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import '../../App.dart';

abstract class BaseViewModel {
  Future initialize() {
    return new Future.sync(() => _onLoad());
  }

  void _onLoad() {
    var textSensitiveModel = this as ILocaleSensitive;
    if (textSensitiveModel != null)
      new App().textProcessor.process(textSensitiveModel);
  }
}
