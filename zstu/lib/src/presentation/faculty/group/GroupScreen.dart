import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../../App.dart';
import '../../../resources/Sizes.dart';
import '../../common/BaseScreenMixin.dart';
import '../../common/TextLocalizations.dart';
import 'YearViewModel.dart';
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
  App _app;
  GroupScreenViewModel _model;
  YearViewModel selectedYear;

  StreamSubscription _connectivityChangeListener;

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
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildImage(),
          _buildHeading(),
          _buildYearDropdown(),
          _buildGroupSelector(),
        ],
      ),
    );
  }

  Widget _buildHeading() {
    return new Container(
      margin: new EdgeInsets.symmetric(
        vertical: Sizes.GroupSelectionHeadingMargin,
      ),
      padding: new EdgeInsets.symmetric(
        horizontal: Sizes.GroupSelectionHeadingPadding,
      ),
      child: new Text(
        texts.selectGroupAndYear,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: Sizes.GroupSelectionHeadingText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildYearDropdown() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(texts.yearSelectorPlaceholder),
        new Container(
          child: new DropdownButton(
            items: _buildYearDropdownItems(),
            onChanged: (x) => setState(() => selectedYear = x),
            value: selectedYear,
            hint: new Text(texts.yearSelectorPlaceholder),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupSelector() {
    return new Text('Group selector');
  }

  List<DropdownMenuItem> _buildYearDropdownItems() {
    return _model?.years?.map((x) {
          return new DropdownMenuItem(
            child: new Text(x.name),
            value: x,
          );
        })?.toList() ??
        <DropdownMenuItem<YearViewModel>>[];
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
      radius: Sizes.GroupSelectionImageRadius,
      backgroundColor: Colors.blue[100],
      backgroundImage: new AssetImage(_app.assets.getAssetPath("FICT.png")),
    );
  }
}
