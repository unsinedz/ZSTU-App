import 'package:flutter/widgets.dart';

typedef BuildContext BuildContextProvider();
abstract class IEmbeddableEditor {
  void setEmbeddableWidget(Widget widget);
  Widget buildEditor(BuildContext context);
}