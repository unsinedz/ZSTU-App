import 'package:flutter/widgets.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';

abstract class LocalizableState<T extends StatefulWidget> extends State<T>
    implements EventListener<LocalizationChangeEvent>, ILocaleSensitive {
  @override
  void initState() {
    subscribeToLocaleChanges();
    super.initState();
  }

  @override
  void dispose() {
    unsubscribeFromLocaleChanges();
    super.dispose();
  }

  void subscribeToLocaleChanges() {
    new App().eventBus.registerListener<LocalizationChangeEvent>(this);
  }

  void unsubscribeFromLocaleChanges() {
    new App().eventBus.removeListener<LocalizationChangeEvent>(this);
  }

  @override
  void handleEvent(LocalizationChangeEvent event, Object sender) {
    initializeForLocale(event.locale);
  }
}
