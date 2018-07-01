import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/settings/SettingViewModel.dart';
import 'package:zstu/src/presentation/settings/SettingsScreenViewModel.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsState();
}

class _SettingsState extends State<SettingsScreen>
    with TextLocalizations, BaseScreenMixin {
  SettingsScreenViewModel _model;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return wrapMaterialLayout(
        _buildInFuture(), buildAppBar(texts.settingsTitle));
  }

  Widget _buildContent() {
    return new ListView(
      controller: _scrollController,
      children: _createSettingList(_model.settingValues),
    );
  }

  List<Widget> _createSettingList(List<SettingViewModel> settingValues) {
    if (settingValues.length == 0) return <Widget>[];

    var widgets = <Widget>[];
    String groupName;
    for (var setting in settingValues) {
      if (groupName != setting.type) {
        groupName = setting.type;
        widgets.add(new ListTile(
          enabled: false,
          title: new Text(setting.type),
        ));
      }

      widgets.add(new ListTile(
        title: new Text(setting.name),
      ));
    }

    return widgets;
  }

  Widget _buildInFuture() {
    if (_model != null) return _buildContent();

    return new FutureBuilder(
      future: new Future(() async {
        _model = new SettingsScreenViewModel();
        await _model.initialize();
      }),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return loadingSpinner();

        if (_model.settingValues == null) return error();

        return _buildContent();
      },
    );
  }
}
