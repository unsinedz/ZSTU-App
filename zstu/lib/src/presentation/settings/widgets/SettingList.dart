import 'package:flutter/widgets.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/widgets/SettingListItem.dart';

class SettingList extends StatefulWidget {
  SettingList({
    @required List<ISettingListItemModel> items,
    @required SettingUpdater settingUpdater,
  })  : assert(items != null),
        this._items = []..addAll(items),
        this._settingUpdater = settingUpdater;

  final List<ISettingListItemModel> _items;
  final SettingUpdater _settingUpdater;

  @override
  State<StatefulWidget> createState() {
    return new _SettingListState(
      items: _items,
      settingUpdater: _settingUpdater,
    );
  }
}

class _SettingListState extends State<SettingList> {
  _SettingListState({
    @required List<ISettingListItemModel> items,
    @required SettingUpdater settingUpdater,
  })  : assert(items != null),
        this._items = []..addAll(items),
        this._settingUpdater = settingUpdater;

  final List<ISettingListItemModel> _items;
  final SettingUpdater _settingUpdater;

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
    String groupName;
    for (var setting in _items) {
      if (groupName != setting.type) {
        groupName = setting.type;
        widgets.add(new SettingListItem.caption(setting: setting));
      }

      widgets.add(
        new SettingListItem.setting(
          setting: setting,
          settingUpdater: _settingUpdater,
        ),
      );
    }

    return widgets;
  }
}
