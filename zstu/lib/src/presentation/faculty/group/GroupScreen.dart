import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../../App.dart';
import '../../../domain/faculty/Year.dart';
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
    super.initState();

    _app = new App();
    _connectivityChangeListener =
        new Connectivity().onConnectivityChanged.listen((r) {
      if (r != ConnectivityResult.none && (_model?.years?.length ?? -1) == 0) {
        print('Connectivity callback');
        setState(() => _model = null);
      }
    });
  }

  @override
  void dispose() {
    _connectivityChangeListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);

    Future modelLoader = _loadModel();
    return wrapMaterialLayout(
      new FutureBuilder(
        future: modelLoader,
        builder: _buildInFuture,
      ),
      buildAppBar(texts.groupTitle),
    );
  }

  Widget _buildContent(BuildContext context) {
    return new Column(
      children: <Widget>[
        _buildImage(),
        new DropdownButton<Year>(
          items: _buildYearDropdownItems(),
          onChanged: _onDropdownChanged,
          value: _model?.selectedYear,
          hint: new Text("Select year"),
        )
      ],
    );
  }

  List<DropdownMenuItem> _buildYearDropdownItems() {
    return _model?.years?.map((x) {
          return new DropdownMenuItem(
            child: new Text(x.name),
            value: x,
          );
        })?.toList() ??
        <DropdownMenuItem<Year>>[];
  }

  void _onDropdownChanged(Year value) {
    setState(() => _model.selectedYear = value);
  }

  Future _loadModel() async {
    if (_model != null) return;

    var instance = new GroupScreenViewModel();
    await instance.initialize();
    _model = instance;
  }

  Widget _buildInFuture(
      BuildContext buildContext, AsyncSnapshot<dynamic> snapshot) {
    if (_model == null && snapshot.connectionState != ConnectionState.done) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    if (_model == null) return new Text("Model is null.");

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
