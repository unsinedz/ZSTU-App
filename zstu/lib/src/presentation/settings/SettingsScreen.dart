import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/core/BuildSettings.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/core/lang/Lazy.dart';
import 'package:zstu/src/domain/common/FutureHelperMixin.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/presentation/common/BaseScreenMixin.dart';
import 'package:zstu/src/presentation/common/LocalizableScreen.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/presentation/editor/EditorConstructor.dart';
import 'package:zstu/src/presentation/editor/IEmbeddableEditor.dart';
import 'package:zstu/src/presentation/editor/ValueEditorFactory.dart';
import 'package:zstu/src/presentation/settings/ISettingListItemModel.dart';
import 'package:zstu/src/presentation/settings/SettingsScreenViewModel.dart';
import 'package:zstu/src/resources/Colors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsState();
}

class _SettingsState extends LocalizableState<SettingsScreen>
    with TextLocalizations, BaseScreenMixin, FutureHelperMixin
    implements ILocaleSensitive, EventListener<LocalizationChangeEvent> {
  SettingsScreenViewModel _model;
  ScrollController _scrollController;

  Lazy<ValueEditorFactory> _valueEditors =
      new Lazy(valueProvider: () => ValueEditorFactory.instance);

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
        widgets.add(_buildGroupNameListItem(setting));
      }

      widgets.add(
        new Builder(builder: (ctx) => _buildSettingListItem(ctx, setting)),
      );
    }

    return widgets;
  }

  Widget _buildGroupNameListItem(ISettingListItemModel setting) {
    return new Column(
      children: [
        Container(
          child: new ListTile(
            enabled: false,
            title: new Text(
              setting.translatedType,
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

  Widget _buildSettingListItem(
      BuildContext context, ISettingListItemModel setting) {
    var tileBuilder = (GestureTapCallback onTap) => new ListTile(
          title: new Text(
            setting.translatedName,
            style: new TextStyle(color: AppColors.SettingItemText),
          ),
          onTap: onTap,
        );

    var settingKey =
        BaseSettings.makeSettingKey(setting.name, type: setting.type);
    if (_valueEditors.getValue().isEditorRegistered(settingKey)) {
      var editor = _valueEditors.getValue().getValueEditor(settingKey);
      var constructor = new EditorConstructor(editor).addOnChange((newValue) {
        if (BuildSettings.instance.enableLogging)
          print('Setting $settingKey changed to $newValue.');

        var settingsManager = new App().settings;
        settingsManager.modifySettings<ApplicationSettings>(
            settingsManager.getApplicationSettings(), (s) {
          s.applicationLanguage = newValue;
          return true;
        });
      });
      if (!editor.embaddable)
        return tileBuilder(() => constructor.construct().build(context));

      return constructor
          .setEmbeddableWidget(tileBuilder(() => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (editor as IEmbeddableEditor).buildEditor))))
          .construct()
          .build(context);
    }

    return tileBuilder(() {});
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
