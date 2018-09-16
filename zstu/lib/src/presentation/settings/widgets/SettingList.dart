import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/presentation/settings/widgets/SettingListItem.dart';

class SettingList extends StatefulWidget {
  SettingList({
    @required List<EditableSetting> items,
  })  : assert(items != null),
        this._items = []..addAll(items);

  final List<EditableSetting> _items;

  @override
  State<StatefulWidget> createState() {
    return new _SettingListState(
      items: _items,
    );
  }
}

class _SettingListState extends State<SettingList> {
  _SettingListState({
    @required List<EditableSetting> items,
  })  : assert(items != null),
        this._items = []..addAll(items);

  final List<EditableSetting> _items;
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
    return new ListView(
      controller: _scrollController,
      children: _buildItems(),
    );
  }

  List<Widget> _buildItems() {
    if (_items.length == 0) return <Widget>[];

    var widgets = <Widget>[];
    for (var setting in _items) {
      if (setting.valueChanged == null || setting.valueDescriptor == null)
        widgets.add(new SettingListItem.caption(
          name: setting.name,
          previewValue: setting.previewValue,
        ));
      else
        widgets.add(
          new SettingListItem.setting(
            name: setting.name,
            previewValue: setting.previewValue,
            settingUpdater: setting.valueChanged,
            value: setting.value,
            valueDescriptor: setting.valueDescriptor,
          ),
        );
    }

    return widgets;
  }
}
