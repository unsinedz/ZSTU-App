import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';

class GenericEditor<T> extends ValueEditor<T> with BaseScreenMixin, TextLocalizations {
  GenericEditor(T value, IValueDescriptor<T> valueDescriptor, String title)
      : super(value, valueDescriptor, title);

  @override
  bool get embaddable => false;

  @override
  Widget construct(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
          builder: _buildEditor,
        ));

    return new Text('');
  }

  Widget _buildEditor(BuildContext context) {
    throw new UnimplementedError();
  }
}
