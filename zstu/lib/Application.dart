import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/core/event/Event.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/core/locale/DefaultLocaleProvider.dart';
import 'package:zstu/src/core/locale/ISupportsLocaleOverride.dart';
import 'package:zstu/src/data/DataModule.dart';
import 'package:zstu/src/domain/common/descriptors/BoolDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';
import 'package:zstu/src/domain/common/descriptors/NumberDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/StringDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/domain/event/ReloadAppEvent.dart';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/NotificationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/AdditionalSettingItem.dart';
import 'package:zstu/src/domain/settings/foundation/SettingListItemsStorage.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/presentation/faculty/FacultyScreen.dart';
import 'package:zstu/src/presentation/faculty/group/GroupScreen.dart';
import 'package:zstu/src/presentation/schedule/ScheduleScreen.dart';
import 'package:zstu/src/presentation/settings/widgets/SettingsScreen.dart';
import 'package:zstu/src/resources/Colors.dart';
import 'package:zstu/src/resources/Texts.dart';

class ZstuApp extends StatefulWidget {
  final List<String> supportedLocales = DefaultLocaleProvider.supportedLocales;

  @override
  State<StatefulWidget> createState() {
    return new _ZstuAppState();
  }

  Future initialize() async {
    await DataModule.configure();
    registerValueDescriptors();
    await initializeSettingListItems();
  }

  void registerValueDescriptors() {
    var descriptorFactory = ValueDescriptorFactory.instance;

    // Types
    descriptorFactory.registerValueDescriptor(
        'String', new StringDescriptor(null));
    descriptorFactory.registerValueDescriptor(
        'num', new NumberDescriptor(null));
    descriptorFactory.registerValueDescriptor(
        'int', new NumberDescriptor(null));
    descriptorFactory.registerValueDescriptor(
        'double', new NumberDescriptor(null));
    descriptorFactory.registerValueDescriptor('bool', new BoolDescriptor());

    // Application settings
    var applicationSettingsType = ApplicationSettings.Type;
    descriptorFactory.registerValueDescriptor(
      _makeSettingKey(
        settingName: 'applicationLanguage',
        settingType: applicationSettingsType,
      ),
      new StringDescriptor(supportedLocales
          .map((x) => new NamedValue<String>(
              DefaultLocaleProvider.buildLocaleKey(localeCode: x), x))
          .toList()),
    );

    var notificationSettingsType = NotificationSettings.Type;
    descriptorFactory.registerValueDescriptor(
        _makeSettingKey(
          settingName: 'scheduleChange',
          settingType: notificationSettingsType,
        ),
        new BoolDescriptor());
  }

  //TODO: remove this storage
  Future initializeSettingListItems() async {
    var storage = SettingListItemsStorage.instance;

    final String suportType = "Support";
    storage.addItem(new AdditionalSettingItem(
      name: "AskQuestion",
      type: suportType,
    ));
    storage.addItem(new AdditionalSettingItem(
      name: "SuggestFeature",
      type: suportType,
    ));
    storage.addItem(new AdditionalSettingItem(
      name: "NoticedProblem",
      type: suportType,
    ));
  }

  String _makeSettingKey({@required String settingName, String settingType}) {
    return BaseSettings.makeSettingKey(settingName, type: settingType);
  }
}

class _ZstuAppState extends State<ZstuApp>
    implements ILocaleSensitive, EventListener {
  _OverrideLocalizationsDelegate _overrideLocalizationsDelegate;

  @override
  void initState() {
    _overrideLocalizationsDelegate = new _OverrideLocalizationsDelegate(null);
    new App().eventBus.registerListener(this, ReloadAppEvent);
    new App().eventBus.registerListener(this, LocalizationChangeEvent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        const _InitLocalizationsDelegate(),
        _overrideLocalizationsDelegate,
        new TextsDelegate(new App().locale),
      ]..addAll(GlobalMaterialLocalizations.delegates),
      supportedLocales:
          widget.supportedLocales.map((x) => new Locale(x, '')).toList(),
      theme: new ThemeData(
        primaryColor: AppColors.Primary,
      ),
      onGenerateTitle: (BuildContext ctx) => Texts.of(ctx).appName,
      home: new FacultiesScreen(),
      routes: <String, WidgetBuilder>{
        '/group': (ctx) => new GroupScreen(),
        '/schedule': (ctx) => new ScheduleScreen(),
        '/settings': (ctx) => new SettingsScreen(),
      },
    );
  }

  @override
  void initializeForLocale(Locale newLocale) {
    (new App().locale as ISupportsLocaleOverride)?.overrideLocale(newLocale);
    setState(() => _overrideLocalizationsDelegate =
        new _OverrideLocalizationsDelegate(newLocale));
  }

  @override
  void handleEvent(Event event, Object sender) {
    if (event is ReloadAppEvent) this.handlerReloadEvent(event, sender);

    if (event is LocalizationChangeEvent)
      this.handleLocalizationEvent(event, sender);
  }

  void handlerReloadEvent(ReloadAppEvent event, Object sender) {
    setState(() {
      if (event.onReloaded != null) event.onReloaded();
    });
  }

  void handleLocalizationEvent(LocalizationChangeEvent event, Object sender) {
    if (event?.locale != null) initializeForLocale(event.locale);
  }

  @override
  void dispose() {
    new App().eventBus.removeListener(this);
    super.dispose();
  }
}

class _InitLocalizationsDelegate extends LocalizationsDelegate {
  const _InitLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future load(Locale locale) => new App()
      .settings
      .getApplicationSettings()
      .then((x) => new App().locale.initialize(
          new Locale(x.applicationLanguage ?? locale.languageCode, '')));

  @override
  bool shouldReload(LocalizationsDelegate old) => true;
}

class _OverrideLocalizationsDelegate extends LocalizationsDelegate {
  _OverrideLocalizationsDelegate(this._overridenLocale);

  final Locale _overridenLocale;

  @override
  bool isSupported(Locale locale) =>
      _overridenLocale != null &&
      new App().locale is ISupportsLocaleOverride &&
      new App().locale.isLocaleSupported(_overridenLocale);

  @override
  Future load(Locale locale) =>
      new Future.sync(() => (new App().locale as ISupportsLocaleOverride)
          .overrideLocale(_overridenLocale));

  @override
  bool shouldReload(LocalizationsDelegate old) => true;
}
