import 'package:flutter/widgets.dart';
import 'package:zstu/src/core/lang/ICloneable.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';

abstract class ValueEditor<T> implements ICloneable<ValueEditor<T>> {
  ValueEditor(this.valueDescriptor, this.title);

  @protected
  final IValueDescriptor<T> valueDescriptor;

  @protected
  final String title;

  bool get embeddable => this is IEmbeddableEditor;

  Widget build(BuildContext context);

  void onChange(T newValue);
}
