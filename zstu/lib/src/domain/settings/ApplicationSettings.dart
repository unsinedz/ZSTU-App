import 'package:zstu/src/domain/settings/NotificationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';

class ApplicationSettings extends BaseSettings {
  SystemSettings system;
  NotificationSettings notifications;

  String get applicationLanguage => getTypedSetting("applicationLanguage");

  set applicationLanguage(String value) =>
      setTypedSetting<String>("applicationLanguage", value);

  static const String Type = "General";

  @override
  String get type => ApplicationSettings.Type;
}
