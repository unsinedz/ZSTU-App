import 'package:flutter/widgets.dart';

typedef void StateUpdater(VoidCallback fn);

abstract class IStatefulEditor {
  void setState(VoidCallback fn);
  void setStateUpdater(StateUpdater stateUpdater);
}