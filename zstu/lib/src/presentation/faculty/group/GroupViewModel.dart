import 'dart:ui';

import '../../../domain/common/text/ITextSensitive.dart';
import '../../../domain/faculty/Group.dart';

class GroupViewModel extends ITextSensitive {
  GroupViewModel.fromGroup(Group group) {
    assert(group != null);

    id = group.id;
    name = group.name;
  }

  String id;

  String name;

  @override
  void translateTexts(Locale locale) {
    throw null;
  }
}