import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/core/event/EventListener.dart';
import 'package:zstu/src/core/locale/DefaultLocaleProvider.dart';
import 'package:zstu/src/core/locale/ISupportsLocaleOverride.dart';
import 'package:zstu/src/data/DataModule.dart';
import 'package:zstu/src/domain/common/descriptors/BoolDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NumberDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/StringDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/AdditionalSettingItem.dart';
import 'package:zstu/src/domain/settings/foundation/AdditionalSettingListItemsStorage.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/presentation/faculty/FacultyScreen.dart';
import 'package:zstu/src/presentation/faculty/group/GroupScreen.dart';
import 'package:zstu/src/presentation/schedule/ScheduleScreen.dart';
import 'package:zstu/src/presentation/settings/SettingsScreen.dart';
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
    initializeSettingListItems();
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
        _makeSettingKey('applicationLanguage',
            settingType: applicationSettingsType),
        new StringDescriptor(supportedLocales));
  }

  void initializeSettingListItems() {
    var storage = AdditionalSettingListItemsStorage.instance;

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

  String _makeSettingKey(String settingName, {String settingType}) {
    return BaseSettings.makeSettingKey(settingName, type: settingType);
  }
}

class _ZstuAppState extends State<ZstuApp>
    implements ILocaleSensitive, EventListener<LocalizationChangeEvent> {
  _OverrideLocalizationsDelegate _overrideLocalizationsDelegate;

  @override
  void initState() {
    _overrideLocalizationsDelegate = new _OverrideLocalizationsDelegate(null);
    new App()?.eventBus?.registerListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        _overrideLocalizationsDelegate,
        const _InitLocalizationsDelegate(),
        new TextsDelegate(new App().locale),
      ]..addAll(GlobalMaterialLocalizations.delegates),
      supportedLocales:
          widget.supportedLocales.map((x) => new Locale(x, '')).toList(),
      theme: new ThemeData(
        primaryColor: AppColors.Primary,
      ),
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
    setState(() => _overrideLocalizationsDelegate =
        new _OverrideLocalizationsDelegate(newLocale));
  }

  @override
  void handleEvent(LocalizationChangeEvent event, Object sender) {
    if (event?.locale != null) initializeForLocale(event.locale);
  }

  @override
  void dispose() {
    new App()?.eventBus?.removeListener(this);
    super.dispose();
  }
}

class _InitLocalizationsDelegate extends LocalizationsDelegate {
  const _InitLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future load(Locale locale) => new Future.sync(() {
        new App().locale.initialize(locale);
        new App().settings.modifySettings<ApplicationSettings>(
            new App().settings.getApplicationSettings(), (s) {
          if (s.applicationLanguage == locale.languageCode) return false;

          s.applicationLanguage = locale.languageCode;
          return true;
        });
      });

  @override
  bool shouldReload(LocalizationsDelegate old) => true;
}

class _OverrideLocalizationsDelegate extends LocalizationsDelegate {
  _OverrideLocalizationsDelegate(this._overridenLocale);

  final Locale _overridenLocale;

  @override
  bool isSupported(Locale locale) =>
      _overridenLocale != null &&
      (new App().locale as ISupportsLocaleOverride) != null &&
      new App().locale.isLocaleSupported(_overridenLocale);

  @override
  Future load(Locale locale) =>
      new Future.sync(() => (new App().locale as ISupportsLocaleOverride)
          .overrideLocale(_overridenLocale));

  @override
  bool shouldReload(LocalizationsDelegate old) => true;
}
