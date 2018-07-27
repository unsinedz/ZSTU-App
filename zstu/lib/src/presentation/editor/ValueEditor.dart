import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';

abstract class ValueEditor<T> {
  ValueEditor(this.valueDescriptor, this.title);

  @protected
  IValueDescriptor<T> valueDescriptor;

  @protected
  String title;

  bool get embaddable => this is IEmbeddableEditor;

  Widget build(BuildContext context);

  void onChange(T newValue);
}
