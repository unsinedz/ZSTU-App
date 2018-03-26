import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/BaseScreenMixin.dart';
import '../../common/TextLocalizations.dart';
import 'GroupScreenViewModel.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen(this._facultyId);

  final String _facultyId;

  @override
  State<StatefulWidget> createState() {
    return new _GroupScreenState(_facultyId);
  }
}

class _GroupScreenState extends State<GroupScreen>
    with TextLocalizations, BaseScreenMixin {
  _GroupScreenState(this._facultyId);

  String _facultyId;

  GroupScreenViewModel _model;

  @override
  Widget build(BuildContext context) {
    return wrapMaterialLayout(
        _buildContent(context), buildAppBar(texts.groupTitle));
  }

  Widget _buildContent(BuildContext context) {
    return new FutureBuilder(
      builder: _buildInFuture,
      future: _getModel(),
    );
  }

  Future<GroupScreenViewModel> _getModel() async {
    if (_model != null) return _model;

    var instance = new GroupScreenViewModel();
    await instance.initialize();
  }

  Widget _buildInFuture(BuildContext buildContext,
      AsyncSnapshot<GroupScreenViewModel> snapshot) {}
}
