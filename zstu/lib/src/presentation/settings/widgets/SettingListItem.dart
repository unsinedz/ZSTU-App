import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';
import 'package:zstu/src/presentation/editor/ListValueEditor.dart';
import 'package:zstu/src/resources/Colors.dart';

class SettingListItem<T> extends StatefulWidget {
  SettingListItem.caption({
    @required String name,
    String previewValue,
  })  : this._name = name,
        this._previewValue = previewValue,
        this._itemType = _ItemType.Caption,
        this._settingUpdater = null,
        this._value = null,
        this._valueDescriptor = null;

  SettingListItem.setting({
    @required String name,
    @required T value,
    @required IValueDescriptor<T> valueDescriptor,
    @required ValueChanged<T> settingUpdater,
    String previewValue,
  })  : this._name = name,
        this._previewValue = previewValue,
        this._itemType = _ItemType.Setting,
        this._settingUpdater = settingUpdater,
        this._value = value,
        this._valueDescriptor = valueDescriptor;

  final String _name;
  final String _previewValue;
  final T _value;
  final IValueDescriptor<T> _valueDescriptor;
  final _ItemType _itemType;
  final ValueChanged<T> _settingUpdater;

  @override
  State<StatefulWidget> createState() {
    return new _SettingListItemState(
      name: _name,
      previewValue: _previewValue,
      value: _value,
      valueDescriptor: _valueDescriptor,
      itemType: _itemType,
      settingUpdater: _settingUpdater,
    );
  }
}

enum _ItemType { Caption, Setting }

class _SettingListItemState<T> extends State<SettingListItem> {
  _SettingListItemState({
    @required String name,
    @required _ItemType itemType,
    @required T value,
    @required IValueDescriptor<T> valueDescriptor,
    @required ValueChanged<T> settingUpdater,
    String previewValue,
  })  : this._name = name,
        this._previewValue = previewValue,
        this._itemType = itemType,
        this._settingUpdater = settingUpdater,
        this._value = value,
        this._valueDescriptor = valueDescriptor;

  final String _name;
  final String _previewValue;
  final T _value;
  final IValueDescriptor<T> _valueDescriptor;
  final _ItemType _itemType;
  final ValueChanged<T> _settingUpdater;

  @override
  Widget build(BuildContext context) {
    switch (_itemType) {
      case _ItemType.Caption:
        return _buildCaption(context);
      case _ItemType.Setting:
        return _buildSetting(context);
      default:
        throw new ArgumentError('Item type $_itemType is not supported.');
    }
  }

  Widget _buildCaption(BuildContext context) {
    return new Column(
      children: [
        new Container(
          child: new ListTile(
            enabled: false,
            title: new Text(
              _name,
              style: new TextStyle(
                color: AppColors.SettingGroupText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          height: 45.0,
        ),
        new Divider(
          color: AppColors.SettingDivider,
          height: 0.0,
        ),
      ],
    );
  }

  Widget _buildSetting(BuildContext context) {
    const textStyle = const TextStyle(color: AppColors.SettingItemText);
    var tileBuilder = (GestureTapCallback onTap) => new ListTile(
          title: new Text(
            _name,
            style: textStyle,
          ),
          trailing: _previewValue == null
              ? null
              : new Text(
                  _previewValue,
                  style: textStyle,
                ),
          onTap: onTap,
        );

    if (_valueDescriptor == null) return tileBuilder(() {});

    return tileBuilder(() {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (BuildContext context) {
        return new ListValueEditor(
          title: _name,
          value: _value,
          valueDescriptor: _valueDescriptor,
          valueSelected: (BuildContext context, dynamic newValue) {
            var navigator = Navigator.of(context);
            if (navigator.canPop()) navigator.pop();

            _settingUpdater(newValue);
          },
        );
      }));
    });
  }
}
