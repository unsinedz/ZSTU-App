import 'dart:collection';
import 'package:zstu/src/core/BuildSettings.dart';
import 'package:zstu/src/core/event/Event.dart';
import 'package:zstu/src/core/event/EventListener.dart';

class EventBus {
  static EventBus _instance;
  static EventBus get instance => _instance = _instance ?? new EventBus();

  Map<Type, EventListener> _defaultEventListeners = {};
  Map<Type, List<EventListener>> _internalEventListeners;
  Map<Type, List<EventListener>> get _eventListeners =>
      _internalEventListeners = _internalEventListeners ??
          new HashMap<Type, List<EventListener>>(equals: (a, b) => a == b);

  void postEvent<T extends Event>(T event, Object sender) {
    if (event == null) throw new ArgumentError("Event is null.");

    if (_eventListeners.containsKey(T)) {
      for (var handler in _eventListeners[T])
        handler.handleEvent(event, sender);
    }

    if (_defaultEventListeners.containsKey(T))
      _defaultEventListeners[T].handleEvent(event, sender);
  }

  void registerDefaultListener<T extends Event>(EventListener<T> eventListener,
      [Type eventType]) {
    if (eventListener == null)
      throw new ArgumentError("Event listener is null.");

    eventType = eventType ?? T;
    if (_defaultEventListeners.containsKey(eventType))
      throw new StateError(
          'Impossible to register more than 1 default listener for event $eventType.');

    _defaultEventListeners[eventType] = eventListener;

    if (BuildSettings.instance.enableLogging)
      print(
          'Registered default listener ${eventListener.toString()} for event ${(eventType ?? T).toString()}.');
  }

  void removeDefaultListener<T extends Event>(EventListener<T> eventListener,
      [Type eventType]) {
    if (eventListener == null)
      throw new ArgumentError("Event listener is null.");

    eventType = eventType ?? T;
    if (_defaultEventListeners.containsKey(eventType))
      _defaultEventListeners.remove(eventType);

    if (BuildSettings.instance.enableLogging)
      print(
          'Unregistered default listener ${eventListener.toString()} for event ${(eventType).toString()}.');
  }

  void registerListener<T extends Event>(EventListener<T> eventListener,
      [Type eventType]) {
    _addListener(eventType ?? T, eventListener);
    if (BuildSettings.instance.enableLogging)
      print(
          'Registered listener ${eventListener.toString()} for event ${(eventType ?? T).toString()}.');
  }

  void removeListener<T extends Event>(EventListener<T> eventListener,
      [Type eventType]) {
    _removeListener(eventType ?? T, eventListener);
    if (BuildSettings.instance.enableLogging)
      print(
          'Unregistered listener ${eventListener.toString()} for event ${(eventType ?? T).toString()}.');
  }

  void _addListener(Type eventType, EventListener eventListener) {
    if (eventListener == null)
      throw new ArgumentError("Event listener is null.");

    if (eventType == null)
      throw new ArgumentError("Event type is not specified.");

    _eventListeners.putIfAbsent(eventType, () => <EventListener>[]);
    _eventListeners[eventType].add(eventListener);
  }

  void _removeListener(Type eventType, EventListener eventListener) {
    if (eventListener == null)
      throw new ArgumentError("Event listener is null.");

    if (eventType == null)
      throw new ArgumentError("Event type is not specified.");

    if (_eventListeners.containsKey(eventType))
      _eventListeners[eventType].remove(eventListener);
  }
}
