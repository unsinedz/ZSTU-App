import 'package:flutter/material.dart';

import '../../common/BaseScreenMixin.dart';
import '../../common/TextLocalizations.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen(this._facultyId);

  final String _facultyId;

  @override
  State<StatefulWidget> createState() {
    return new _GroupScreenState(_facultyId);
  }
}

class _GroupScreenState extends State<GroupScreen> with TextLocalizations, BaseScreenMixin {
  _GroupScreenState(this._facultyId);

  String _facultyId;

  @override
  Widget build(BuildContext context) {
    return wrapMaterialLayout(_buildInFuture(context), buildAppBar(texts.groupTitle));
  }

  Widget _buildInFuture(BuildContext context) {
    return new FutureBuilder(
      builder: null,
      future: null,
    );
  }
}