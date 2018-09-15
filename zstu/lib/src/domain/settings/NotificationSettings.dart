import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';

class NotificationSettings extends BaseSettings {
  static const String Type = "Notification";

  @override
  String get type => NotificationSettings.Type;

  bool get scheduleChange => getSettingOrDefault("scheduleChange", false);
}
