import 'package:zstu/src/domain/settings/SettingsBase.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';

class ApplicationSettings extends SettingsBase {
  SystemSettings system;

  @override
  String get type => "General";
}
