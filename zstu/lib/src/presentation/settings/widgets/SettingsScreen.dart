import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/domain/event/ReloadAppEvent.dart';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
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
    implements ILocaleSensitive {
  SettingsScreenViewModel _model;
  ScrollController _scrollController;

  Future _pendingOperation;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _pendingOperation = new Future(() async {
      _model = new SettingsScreenViewModel();
      await _model.initialize();
    });
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
      content: _buildInFuture(_pendingOperation),
      appBar: buildAppBar(texts.settingsTitle),
    );
  }

  Widget _buildContent() {
    return new SettingList(
      items: _getSettings().toList(),
    );
  }

  Iterable<EditableSetting> _getSettings() sync* {
    var valueDescriptors = ValueDescriptorFactory.instance;
    yield new EditableSetting(
      name: texts["Setting_General"],
      previewValue: texts["Setting_General"],
    );
    yield new EditableSetting(
        name: texts.applicationLanguage,
        previewValue: null,
        value: _model.applicationSettings.applicationLanguage,
        valueChanged: (newLanguage) {
          if (newLanguage != null &&
              newLanguage.isNotEmpty &&
              newLanguage is String) {
            setState(() {
              _pendingOperation =
                  _model.updateSettings((ApplicationSettings settings) {
                if (settings.applicationLanguage == newLanguage) return false;

                settings.applicationLanguage = newLanguage;
                return true;
              }).then((bool updated) {
                if (updated) {
                  new App().eventBus.postEvent(
                      new ReloadAppEvent(onReloaded: () {
                    new App().eventBus.postEvent(
                        new LocalizationChangeEvent(
                            new Locale(newLanguage, '')),
                        this);
                  }), this);
                }
              });
            });
          }
        },
        valueDescriptor: valueDescriptors.getValueDescriptor(
          BaseSettings.makeSettingKey(
            "applicationLanguage",
            type: ApplicationSettings.Type,
          ),
        ));
  }

  Widget _buildInFuture(Future operation) {
    return new FutureBuilder(
      future: operation,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) return error();

        if (snapshot.connectionState != ConnectionState.done)
          return loadingSpinner();

        if (_model.applicationSettings == null) return error();

        return _buildContent();
      },
    );
  }

  @override
  void initializeForLocale(Locale locale) {
    setState(() {
      _pendingOperation = _model.reload();
    });
  }
}
