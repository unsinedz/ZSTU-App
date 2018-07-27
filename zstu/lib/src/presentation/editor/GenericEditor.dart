import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/presentation/editor/ValueEditor.dart';

abstract class GenericEditor<T> extends ValueEditor<T> {
  GenericEditor(IValueDescriptor<T> valueDescriptor, String title)
      : super(valueDescriptor, title);

  @override
  Widget build(BuildContext context);
}
