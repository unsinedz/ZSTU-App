import 'dart:ui';

import '../../../domain/common/text/ITextSensitive.dart';
import '../../../domain/faculty/Group.dart';

class GroupViewModel extends ITextSensitive {
  GroupViewModel.fromGroup(Group group) {
    if (group == null)
      throw new ArgumentError("Group is null.");

      _group = group;
  }

  GroupViewModel.empty();

  Group _group;

  String get id => _group?.id;

  String get name => _group?.name;

  Group toGroup() {
    return _group;
  }

  @override
  void translateTexts(Locale locale) {
    throw null;
  }
}