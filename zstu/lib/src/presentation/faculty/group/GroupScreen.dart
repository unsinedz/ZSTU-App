import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../../App.dart';
import '../../../domain/common/process/IStep.dart';
import '../../../domain/schedule/ScheduleSelectionProcess.dart';
import '../../../resources/Sizes.dart';
import '../../common/BaseScreenMixin.dart';
import '../../common/TextLocalizations.dart';
import 'GroupViewModel.dart';
import 'YearViewModel.dart';
import 'GroupScreenViewModel.dart';

class GroupScreen extends StatefulWidget
    implements IStep<ScheduleSelectionProcess> {
  @override
  State<StatefulWidget> createState() {
    return new _GroupScreenState();
  }

  @override
  bool canBeExecuted(ScheduleSelectionProcess process) {
    return (process?.faculty != null) ?? false;
  }
}

class _GroupScreenState extends State<GroupScreen>
    with TextLocalizations, BaseScreenMixin {
  App _app;

  ScheduleSelectionProcess _scheduleSelectionProcess;
  ScrollController _scrollController;

  GroupScreenViewModel _model;
  YearViewModel selectedYear;

  StreamSubscription _connectivityChangeListener;

  bool loadInProgress = false;

  @override
  void initState() {
    super.initState();

    _app = new App();
    _connectivityChangeListener =
        new Connectivity().onConnectivityChanged.listen((r) {
      if (r != ConnectivityResult.none && (_model?.years?.length ?? -1) == 0) {
        setState(() => _model = null);
      }
    });
    _scrollController = new ScrollController();
    _scheduleSelectionProcess = _app.processes.scheduleSelection;
    if (!_scheduleSelectionProcess.canExecuteStep(widget))
      throw new StateError("Step can not be executed.");
  }

  @override
  void dispose() {
    _connectivityChangeListener?.cancel();
    _scrollController.dispose();
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
          _buildGroupDropdown(),
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
        new Text(texts.yearSelectorLabel),
        new Container(
          child: new DropdownButton<YearViewModel>(
            items: _buildYearDropdownItems(),
            onChanged: _handleYearSelected,
            value: selectedYear,
            hint: new Text(texts.yearSelectorPlaceholder),
          ),
        ),
      ],
    );
  }

  void _handleYearSelected(YearViewModel selectedYear) {
    assert(selectedYear != null);

    setState(() {
      this.selectedYear = selectedYear;
      loadInProgress = true;
    });
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

  Widget _buildGroupDropdown() {
    var items = _buildGroupDropdownItems();
    var dd = new DropdownButton<GroupViewModel>(
      items: items,
      onChanged: (x) => setState(() {}),
      hint: new Text(texts.groupSelectorPlaceholder),
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(texts.groupSelectorLabel),
        new Container(
          child: items.length == 0
              ? new DropdownButtonHideUnderline(
                  child: dd,
                )
              : dd,
        ),
      ],
    );
  }

  List<DropdownMenuItem> _buildGroupDropdownItems() {
    return _model?.groups?.map((x) {
          return new DropdownMenuItem<GroupViewModel>(
            child: new Text(x.name),
            value: x,
          );
        })?.toList() ??
        <DropdownMenuItem<GroupViewModel>>[];
  }

  Future _loadModel() async {
    if (_model != null) return;

    var instance = new GroupScreenViewModel();
    await instance.initialize();
    if (selectedYear != null) {
      await _model.loadGroups(
          _scheduleSelectionProcess.faculty, selectedYear.toYear());

      loadInProgress = false;
    }

    _model = instance;
  }

  Widget _buildInFuture(
      BuildContext buildContext, AsyncSnapshot<dynamic> snapshot) {
    if (loadInProgress ||
        (_model == null && snapshot.connectionState != ConnectionState.done)) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    if (_model == null) return new Text("Model was not loaded.");

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
