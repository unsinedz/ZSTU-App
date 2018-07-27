import 'package:flutter/widgets.dart';
import 'package:zstu/src/presentation/editor/IDynamicallyChangableEditor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';

class EditorConstructor<TValue, TEditor extends ValueEditor<TValue>> {
  EditorConstructor(TEditor editor)
      : this._editor = editor,
        assert(_editor != null);

  final TEditor _editor;

  EditorConstructor<TValue, TEditor> addOnChange(
      ValueChanged<TValue> onChange) {
    if (_editor is IDynamicallyChangableEditor)
      (_editor as IDynamicallyChangableEditor).addOnChange(onChange);

    return this;
  }

  EditorConstructor<TValue, TEditor> setEmbeddableWidget(Widget widget) {
    if (_editor is IEmbeddableEditor)
      (_editor as IEmbeddableEditor).setEmbeddableWidget(widget);

    return this;
  }

  TEditor construct() {
    return _editor;
  }
}
