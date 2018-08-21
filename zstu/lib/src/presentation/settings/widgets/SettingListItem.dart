import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/core/lang/Lazy.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/presentation/editor/EditorConstructor.dart';
import 'package:zstu/src/presentation/editor/ValueEditorFactory.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/ISettingValueItem.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';
import 'package:zstu/src/resources/Colors.dart';

typedef Future<bool> SettingUpdater<TValue>(
    ISettingListItemModel setting, TValue newValue);

class SettingListItem extends StatefulWidget {
  SettingListItem.caption({
    @required ISettingListItemModel setting,
  })  : this._setting = setting,
        this._itemType = _ItemType.Caption,
        this._settingUpdater = null;

  SettingListItem.setting({
    @required ISettingListItemModel setting,
    @required SettingUpdater settingUpdater,
  })  : this._setting = setting,
        this._itemType = _ItemType.Setting,
        this._settingUpdater = settingUpdater;

  final ISettingListItemModel _setting;
  final _ItemType _itemType;
  final SettingUpdater _settingUpdater;

  @override
  State<StatefulWidget> createState() {
    return new _SettingListItemState(
      setting: _setting,
      itemType: _itemType,
      settingUpdater: _settingUpdater,
    );
  }
}

enum _ItemType { Caption, Setting }

class _SettingListItemState extends State<SettingListItem> {
  _SettingListItemState({
    @required ISettingListItemModel setting,
    @required _ItemType itemType,
    @required SettingUpdater settingUpdater,
  })  : this._setting = setting,
        this._itemType = itemType,
        this._settingUpdater = settingUpdater,
        assert(setting != null);

  final ISettingListItemModel _setting;
  final _ItemType _itemType;
  SettingUpdater _settingUpdater;

  final Lazy<ValueEditorFactory> _valueEditors =
      new Lazy(valueProvider: () => ValueEditorFactory.instance);

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
        Container(
          child: new ListTile(
            enabled: false,
            title: new Text(
              _setting.translatedType,
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
            _setting.translatedName,
            style: textStyle,
          ),
          trailing: _setting.valueDescriptor != null && _setting.valueDescriptor.canBeStringified() && _setting is ISettingValueItem
              ? new Text(_setting.valueDescriptor.stringify((_setting as ISettingValueItem).value))
              : null,
          onTap: onTap,
        );

    var settingKey =
        BaseSettings.makeSettingKey(_setting.name, type: _setting.type);
    if (_valueEditors.getValue().isEditorRegistered(settingKey)) {
      var editor = _valueEditors.getValue().getValueEditor(settingKey);
      var onValueChange = (x, [VoidCallback cb]) =>
          _settingUpdater(_setting, x).whenComplete(cb);
      var constructor = new EditorConstructor(editor)
          .setStateUpdater(this.setState)
          .addOnChange((newValue) => onValueChange(
              newValue,
              editor.embeddable
                  ? () => setState(() {
                        if (_setting is ISettingValueItem)
                          (_setting as ISettingValueItem).value = newValue;
                      })
                  : () {}))
          .setTextStyle(textStyle);
      if (editor.embeddable) {
        return constructor
            .setValueMask(_extractSettingValue(_setting))
            .construct()
            .build(context);
      }

      return tileBuilder(() => Navigator
          .of(context)
          .push(new MaterialPageRoute(builder: constructor.construct().build)));
    }

    return tileBuilder(() {});
  }

  T _extractSettingValue<T>(ISettingListItemModel model) {
    if (model is SettingViewModel<T>) return model.value;

    return null;
  }
}
