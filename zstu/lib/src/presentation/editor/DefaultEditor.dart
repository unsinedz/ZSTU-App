import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/editor/GenericEditor.dart';
import 'package:zstu/src/presentation/editor/IDynamicallyChangeableEditor.dart';
import 'package:zstu/src/presentation/editor/MultipleChangeSubscriptionEditorMixin.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';
import 'package:zstu/src/resources/Texts.dart';

class DefaultEditor<T> extends GenericEditor<T>
    with
        BaseScreenMixin,
        TextLocalizations,
        MultipleChangeSubscriptionEditorMixin<T>
    implements ILocaleSensitive, IDynamicallyChangeableEditor {
  DefaultEditor({
    @required IValueDescriptor<T> valueDescriptor,
    @required String title,
    ValueChanged<T> onChange,
  }) : super(valueDescriptor, title) {
    setDefaultOnChange(onChange);
  }

  String _translatedTitle;

  List<NamedValue<T>> _possibleValues;

  @override
  Widget build(BuildContext context) {
    initializeForLocale(new App().locale.getApplicationLocale());
    return wrapMaterialLayout(
      appBar: buildAppBar(_translatedTitle),
      content: new ListView(
        children: _possibleValues
            .map((x) => new ListTile(
                  title: new Text(x.name),
                  onTap: () => onChange(x.value),
                ))
            .toList(),
      ),
    );
  }

  @override
  void initializeForLocale(Locale locale) {
    _translatedTitle = Texts.getText(title, locale.languageCode, title);
    _possibleValues = valueDescriptor.getPossibleValues()
      ..forEach((x) => x.initializeForLocale(locale));
  }

  @override
  void onChange(T newValue) => this.handleChange(newValue);

  @override
  ValueEditor<T> clone() {
    var clone = new DefaultEditor(
        title: this.title, valueDescriptor: this.valueDescriptor);
    cloneHandlers(clone);
    if (this._possibleValues != null)
      clone._possibleValues = []..addAll(this._possibleValues);

    clone._translatedTitle = this._translatedTitle;
    return clone;
  }
}
