import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/LocalizableScreen.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/settings/SettingsScreenViewModel.dart';
import 'package:zstu/src/presentation/settings/widgets/SettingList.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends LocalizableState<SettingsScreen>
    with TextLocalizations, BaseScreenMixin, FutureHelperMixin
    implements ILocaleSensitive, EventListener<LocalizationChangeEvent> {
  SettingsScreenViewModel _model;

  @override
  Widget build(BuildContext context) {
    return wrapMaterialLayout(
      content: _buildInFuture(),
      appBar: buildAppBar(texts.settingsTitle),
    );
  }

  Widget _buildContent() {
    return new SettingList(
      items: _model.settingValues,
      settingUpdater: _model.updateSettingItem,
    );
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
