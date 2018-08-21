import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/presentation/editor/IDynamicallyChangeableEditor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';
import 'package:zstu/src/presentation/editor/IStatefulEditor.dart';
import 'package:zstu/src/presentation/editor/ITextStyleableEditor.dart';
import 'package:zstu/src/presentation/editor/MultipleChangeSubscriptionEditorMixin.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';
import 'package:zstu/src/resources/Texts.dart';

class BoolListTileEditor extends ValueEditor<bool>
    with MultipleChangeSubscriptionEditorMixin<bool>
    implements
        ILocaleSensitive,
        IEmbeddableEditor<bool>,
        IDynamicallyChangeableEditor<bool>,
        ITextStyleableEditor,
        IStatefulEditor {
  BoolListTileEditor({
    @required IValueDescriptor<bool> valueDescriptor,
    @required String title,
    ValueChanged<bool> onChange,
  }) : super(valueDescriptor, title) {
    setDefaultOnChange(onChange);
  }

  @override
  bool valueMask;

  String _translatedTitle;
  TextStyle _textStyle;
  StateUpdater _stateUpdater;

  void setStateUpdater(StateUpdater stateUpdater) {
    if (stateUpdater == null)
      throw new ArgumentError('State updater must be specified.');

    this._stateUpdater = stateUpdater;
  }

  @override
  Widget build(BuildContext context) {
    initializeForLocale(new App().locale.getApplicationLocale());
    return new SwitchListTile(
      value: valueMask,
      onChanged: onChange,
      title: new Text(
        _translatedTitle,
        style: _textStyle,
      ),
    );
  }

  @override
  void initializeForLocale(Locale locale) {
    _translatedTitle = Texts.getText(title, locale.languageCode, title);
  }

  @override
  void onChange(bool newValue) => this.handleChange(newValue);

  @override
  ValueEditor<bool> clone() {
    var clone = new BoolListTileEditor(
        title: this.title, valueDescriptor: this.valueDescriptor);
    cloneHandlers(clone);
    clone._translatedTitle = this._translatedTitle;
    clone.valueMask = this.valueMask;
    return clone;
  }

  @override
  void setTextStyle(TextStyle textStyle) {
    setState(() => this._textStyle = textStyle);
  }

  @override
  void setState(VoidCallback fn) {
    if (this._stateUpdater == null)
      throw new StateError('State updater was not initialized.');

    _stateUpdater(fn);
  }
}
