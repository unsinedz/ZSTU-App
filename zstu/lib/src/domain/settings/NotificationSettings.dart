import 'package:zstu/src/domain/common/descriptors/ValueDescriptorFactory.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSettingsMixin.dart';
import 'package:zstu/src/domain/settings/foundation/IHasEditableSettings.dart';

class NotificationSettings extends BaseSettings
    with EditableSettingsMixin
    implements IHasEditableSettings {
  static const String Type = "Notification";

  @override
  String get type => NotificationSettings.Type;

  bool get scheduleChange => getSettingOrDefault("scheduleChange", false);

  @override
  List<EditableSetting> getEditableSettings() {
    var descriptorFactory = ValueDescriptorFactory.instance;
    return [
      makeSettingEntry("scheduleChange", scheduleChange),
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
