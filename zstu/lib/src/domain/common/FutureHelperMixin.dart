import 'package:zstu/src/core/BuildSettings.dart';

abstract class FutureHelperMixin {
  void logAndRethrow(dynamic e) {
    if (BuildSettings.instance.enableLogging) print('Error occurred: $e');

    throw e;
  }
}
