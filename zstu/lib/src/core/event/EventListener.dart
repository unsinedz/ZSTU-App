import 'package:zstu/src/core/event/Event.dart';

abstract class EventListener<T extends Event> {
  void handleEvent(T event, Object sender);
}