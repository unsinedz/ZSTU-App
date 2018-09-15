import 'package:flutter/foundation.dart';
import 'package:zstu/src/core/event/Event.dart';

class ReloadAppEvent extends Event {
  ReloadAppEvent({this.onReloaded}) : super(Name);

  static const String Name = 'ReloadApp';

  final VoidCallback onReloaded;
}
