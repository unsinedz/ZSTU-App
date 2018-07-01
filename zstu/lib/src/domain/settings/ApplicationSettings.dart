import 'package:zstu/src/domain/settings/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';

class ApplicationSettings extends BaseSettings {
  SystemSettings system;

  String applicationLanguage;

  static const String Type = "General";

  @override
  String get type => ApplicationSettings.Type;
}
