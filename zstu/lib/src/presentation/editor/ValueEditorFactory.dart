import 'dart:collection';

import 'package:zstu/src/presentation/editor/ValueEditor.dart';

class ValueEditorFactory {
  static ValueEditorFactory _instance;
  static ValueEditorFactory get instance =>
      _instance = _instance ?? new ValueEditorFactory();

  Map<String, ValueEditor> _valueEditors = new HashMap();

  void registerValueEditor<T>(String type, ValueEditor<T> valueEditor) {
    if (_valueEditors.containsKey(type))
      throw new StateError('Value editor has already been registered.');

    _valueEditors[type] = valueEditor;
  }

  ValueEditor<T> getValueEditor<T>(String type) {
    var result = _valueEditors[type];
    if (result == null)
      throw new StateError(
          'Value editor with the name $type has not been registered yet.');

    return result.clone();
  }

  bool isEditorRegistered(String type) {
    return _valueEditors.containsKey(type);
  }
}
