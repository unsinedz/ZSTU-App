import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';
import 'package:zstu/src/resources/Texts.dart';

class BoolListTileEditor extends ValueEditor<bool> implements ILocaleSensitive {
  BoolListTileEditor({
    @required bool value,
    @required IValueDescriptor<bool> valueDescriptor,
    @required String title,
    @required ValueChanged<bool> onChange,
  })  : this._onChange = onChange,
        this._value = value,
        super(valueDescriptor, title);
  bool _value;

  ValueChanged<bool> _onChange;

  String _translatedTitle;

  @override
  bool get embaddable => true;

  @override
  Widget build(BuildContext context) {
    return new SwitchListTile(
      value: _value,
      onChanged: onChange,
      title: new Text(_translatedTitle),
    );
  }

  @override
  void initializeForLocale(Locale locale) {
    _translatedTitle = Texts.getText(title, locale.languageCode, title);
  }

  @override
  void onChange(bool newValue) => _onChange(newValue);
}
