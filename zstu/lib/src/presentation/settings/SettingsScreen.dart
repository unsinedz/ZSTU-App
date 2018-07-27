import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/SettingsScreenViewModel.dart';
import 'package:zstu/src/resources/Colors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsState();
}

class _SettingsState extends State<SettingsScreen>
    with TextLocalizations, BaseScreenMixin, FutureHelperMixin
    implements ILocaleSensitive, EventListener<LocalizationChangeEvent> {
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
      content: _buildInFuture(),
      appBar: buildAppBar(texts.settingsTitle),
    );
  }

  Widget _buildContent() {
    return new ListView(
      controller: _scrollController,
      children: _createSettingList(_model.settingValues),
    );
  }

  List<Widget> _createSettingList(List<ISettingListItemModel> settingValues) {
    if (settingValues.length == 0) return <Widget>[];

    var widgets = <Widget>[];
    String groupName;
    for (var setting in settingValues) {
      if (groupName != setting.type) {
        groupName = setting.type;
        widgets.add(new Container(
          child: new ListTile(
            enabled: false,
            title: new Text(
              setting.type,
              style: new TextStyle(
                color: AppColors.SettingGroupText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          height: 45.0,
        ));
        widgets.add(new Divider(
          color: AppColors.SettingDivider,
          height: 0.0,
        ));
      }

      widgets.add(new ListTile(
        title: new Text(
          setting.name,
          style: new TextStyle(color: AppColors.SettingItemText),
        ),
        onTap: () {},
      ));
    }

    return widgets;
  }

  Widget _buildInFuture() {
    if (_model != null) return _buildContent();

    return new FutureBuilder(
      future: new Future(() async {
        _model = new SettingsScreenViewModel();
        await _model.initialize().catchError(logAndRethrow);
      }),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return loadingSpinner();

        if (_model.settingValues == null) return error();

        return _buildContent();
      },
    );
  }

  @override
  void handleEvent(LocalizationChangeEvent event, Object sender) {
    this.initializeForLocale(event.locale);
  }

  @override
  void initializeForLocale(Locale locale) {
    setState(() => _model = null);
  }
}
