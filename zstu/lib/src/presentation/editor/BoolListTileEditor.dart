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
    @required ValueChanged<bool> onChanged,
  })  : this._onChanged = onChanged,
        super(
          value: value,
          valueDescriptor: valueDescriptor,
          title: title,
        );

  ValueChanged<bool> _onChanged;

  String _translatedTitle;

  @override
  bool get embaddable => true;

  @override
  Widget construct(BuildContext context) {
    return new SwitchListTile(
      value: value,
      onChanged: _onChanged,
      title: new Text(_translatedTitle),
    );
  }

  @override
  void initializeForLocale(Locale locale) {
    _translatedTitle = Texts.getText(title, locale.languageCode, title);
  }
}
