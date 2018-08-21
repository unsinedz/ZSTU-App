import 'package:flutter/widgets.dart';
import 'package:zstu/src/presentation/editor/IDynamicallyChangeableEditor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';
import 'package:zstu/src/presentation/editor/IStatefulEditor.dart';
import 'package:zstu/src/presentation/editor/ITextStyleableEditor.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';

class EditorConstructor<TValue, TEditor extends ValueEditor<TValue>> {
  EditorConstructor(TEditor editor)
      : this._editor = editor,
        assert(_editor != null);

  final TEditor _editor;

  EditorConstructor<TValue, TEditor> addOnChange(
      ValueChanged<TValue> onChange) {
    if (_editor is IDynamicallyChangeableEditor)
      (_editor as IDynamicallyChangeableEditor).addOnChange(onChange);

    return this;
  }

  EditorConstructor<TValue, TEditor> setValueMask(TValue value) {
    if (_editor is IEmbeddableEditor)
      (_editor as IEmbeddableEditor).valueMask = value;

    return this;
  }

  EditorConstructor<TValue, TEditor> setTextStyle(TextStyle textStyle) {
    if (_editor is ITextStyleableEditor)
      (_editor as ITextStyleableEditor).setTextStyle(textStyle);

    return this;
  }

  EditorConstructor<TValue, TEditor> setStateUpdater(
      StateUpdater stateUpdater) {
    if (_editor is IStatefulEditor)
      (_editor as IStatefulEditor).setStateUpdater(stateUpdater);

    return this;
  }

  TEditor construct() {
    return _editor;
  }
}
