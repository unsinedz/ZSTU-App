import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';

typedef Future ValueSelected<T>(BuildContext context, T newValue);

class ListValueEditor<T> extends StatefulWidget {
  ListValueEditor({
    @required String title,
    @required IValueDescriptor<T> valueDescriptor,
    @required T value,
    @required ValueSelected valueSelected,
  })  : this._title = title,
        this._valueDescriptor = valueDescriptor,
        this._valueSelected = valueSelected,
        this._value = value;

  final String _title;
  final IValueDescriptor<T> _valueDescriptor;
  final T _value;
  final ValueSelected _valueSelected;

  @override
  State<StatefulWidget> createState() => new _State<T>(
        title: this._title,
        valueDescriptor: this._valueDescriptor,
        value: this._value,
        valueSelected: this._valueSelected,
      );
}

class _State<T> extends State<ListValueEditor>
    with BaseScreenMixin, TextLocalizations {
  _State({
    @required String title,
    @required IValueDescriptor<T> valueDescriptor,
    @required T value,
    @required ValueSelected valueSelected,
  })  : this._title = title,
        this._valueDescriptor = valueDescriptor,
        this._valueSelected = valueSelected,
        this._value = value;

  final String _title;
  final IValueDescriptor<T> _valueDescriptor;
  final T _value;
  final ValueSelected _valueSelected;

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return wrapMaterialLayout(
        appBar: buildAppBar(_title), content: _buildContent());
  }

  Widget _buildContent() {
    return new ListView(
      controller: this._scrollController,
      children:
          _valueDescriptor.getPossibleValues().map(_buildListItem).toList(),
    );
  }

  Widget _buildListItem(NamedValue namedValue) {
    return new Builder(
      builder: (BuildContext context) => new ListTile(
            title: new Text(texts[namedValue.name]),
            onTap: () => _valueSelected(context, namedValue.value),
          ),
    );
  }
}
