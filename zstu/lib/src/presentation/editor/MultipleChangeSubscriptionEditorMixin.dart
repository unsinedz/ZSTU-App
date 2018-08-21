import 'package:flutter/foundation.dart';

abstract class MultipleChangeSubscriptionEditorMixin<T> {
  List<ValueChanged<T>> _onChangeHandlers = <ValueChanged<T>>[];
  ValueChanged<T> _defaultOnChange;

  void setDefaultOnChange(ValueChanged<T> onChange) {
    this._defaultOnChange = onChange;
  }

  void addOnChange(ValueChanged<T> onChange) {
    this._onChangeHandlers.add(onChange);
  }

  void cloneHandlers(MultipleChangeSubscriptionEditorMixin<T> target) {
    target._defaultOnChange = this._defaultOnChange;
    if (this._onChangeHandlers != null)
      target._onChangeHandlers = []..addAll(this._onChangeHandlers);
  }

  @protected
  void handleChange(T newValue) {
    this._onChangeHandlers.forEach((x) => x(newValue));
    if (this._defaultOnChange != null) this._defaultOnChange(newValue);
  }
}
