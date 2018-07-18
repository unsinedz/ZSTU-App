import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSettingsMixin.dart';
import 'package:zstu/src/domain/settings/foundation/IHasEditableSettings.dart';

class ApplicationSettings extends BaseSettings
    with EditableSettingsMixin
    implements IHasEditableSettings {
  SystemSettings system;

  String get applicationLanguage => getSetting("applicationLanguage");

  set applicationLanguage(String value) =>
      setSetting<String>("applicationLanguage", value);

  static const String Type = "General";

  @override
  String get type => ApplicationSettings.Type;

  @override
  List<EditableSetting> getEditableSettings() {
    var descriptorFactory = ValueDescriptorFactory.instance;
    return [
      makeSettingEntry("applicationLanguage", applicationLanguage),
    ]
        .map((x) => createEditableSetting(
              descriptorFactory,
              x.item1,
              x.item2,
              settingType: type,
            ))
        .toList();
  }
}
