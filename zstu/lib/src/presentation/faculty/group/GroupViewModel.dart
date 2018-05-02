import 'dart:ui';

import '../../../domain/common/text/ITextSensitive.dart';
import '../../../domain/faculty/Group.dart';

class GroupViewModel extends ITextSensitive {
  GroupViewModel.fromGroup(Group group) {
    if (group == null)
      throw new ArgumentError("Group is null.");

    id = group.id;
    name = group.name;
  }

  GroupViewModel.empty();

  String id;

  String name;

  @override
  void translateTexts(Locale locale) {
    throw null;
  }
}