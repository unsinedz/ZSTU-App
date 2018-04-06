import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../App.dart';
import '../../../resources/Sizes.dart';
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
  StreamSubscription _connectivityChangeListener;
  App _app;
  GroupScreenViewModel _model;

  @override
  void initState() {
    _app = new App();
    _connectivityChangeListener =
        new Connectivity().onConnectivityChanged.listen((r) {
      if (r != ConnectivityResult.none && (_model?.years?.length ?? -1) == 0) {
        setState(() => _model = null);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);

    return wrapMaterialLayout(
        new FutureBuilder(
          future: _getModel(),
          builder: _buildInFuture,
        ),
        buildAppBar(texts.groupTitle));
  }

  Widget _buildContent(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          _buildImage(),
          new DropdownButton(
            items: <DropdownMenuItem>[],
            onChanged: _onDropdownChanged,
          )
        ],
      ),
    );
  }

  void _onDropdownChanged(dynamic value) {

  }

  Future<GroupScreenViewModel> _getModel() async {
    if (_model != null) return new SynchronousFuture(_model);

    var instance = new GroupScreenViewModel();
    await instance.initialize();
    return _model = instance;
  }

  Widget _buildInFuture(
      BuildContext buildContext, AsyncSnapshot<GroupScreenViewModel> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    var model = snapshot.data;
    if (model == null) return new Text("Model is null.");

    return _buildContent(context);
  }

  Widget _buildImage() {
    return new CircleAvatar(
      radius: Sizes.FacultiesGridImageRadius,
      backgroundColor: Colors.blue[100],
      backgroundImage: new AssetImage(_app.assets.getAssetPath("FICT.png")),
    );
  }
}
