import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../../App.dart';
import '../../../domain/common/process/IStep.dart';
import '../../../domain/schedule/ScheduleSelectionProcess.dart';
import '../../../resources/Sizes.dart';
import '../../common/BaseScreenMixin.dart';
import '../../common/TextLocalizations.dart';
import '../../schedule/ScheduleScreen.dart';
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
  YearViewModel _selectedYear;

  StreamSubscription _connectivityChangeListener;

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

    Future modelLoader = _model == null
        ? _loadModel()
        : _selectedYear == null
            ? Future.value(null)
            : _model.loadGroups(
                _scheduleSelectionProcess.faculty, _selectedYear.toYear());

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
      child: new Padding(
        padding: new EdgeInsets.symmetric(
          horizontal: Sizes.GroupSelectionHeadingPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildImage(),
            _buildHeading(),
            _buildYearDropdown(),
            _buildGroupDropdown(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return new Container(
      margin: new EdgeInsets.symmetric(
        vertical: Sizes.GroupSelectionButtonMargin,
      ),
      child: new Builder(
        builder: (ctx) => new RaisedButton.icon(
              icon: new Icon(Icons.search),
              label: new Text(
                texts.findSchedule,
                style:
                    new TextStyle(fontSize: Sizes.GroupSelectionButtonTextSize),
              ),
              color: Colors.yellow,
              onPressed: () => _handleSubmitPressed(ctx),
            ),
      ),
    );
  }

  void _handleSubmitPressed(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (ctx) => new ScheduleScreen(),
        ));
  }

  Widget _buildHeading() {
    return new Container(
      margin: new EdgeInsets.symmetric(
        vertical: Sizes.GroupSelectionHeadingMargin,
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
        new Container(
          width: double.infinity,
          alignment: new Alignment(0.0, 0.0),
          child: _buildGroupScreenDropdown<YearViewModel>(
            _buildYearDropdownItems(),
            _handleYearSelected,
            _selectedYear,
            new Text(texts.yearSelectorPlaceholder),
          ),
        ),
      ],
    );
  }

  void _handleYearSelected(YearViewModel selectedYear) {
    assert(selectedYear != null);

    setState(() {
      if (selectedYear != _selectedYear) {
        _model.groups?.clear();
        _model.groups = null;
      }

      _selectedYear = selectedYear;
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
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: _buildGroupScreenDropdown<GroupViewModel>(
                _buildGroupDropdownItems(),
                _handleGroupSelected,
                _getSelectedGroup(),
                new Text(texts.groupSelectorPlaceholder)),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupScreenDropdown<T>(List<DropdownMenuItem<T>> items,
      ValueChanged<T> onChanged, T value, Widget hint) {
    return new DropdownButton<T>(
      items: items,
      onChanged: onChanged,
      value: value,
      hint: hint,
      style: new TextStyle(
        fontSize: Sizes.GroupSelectionDropdownTextSize,
        color: Colors.black,
      ),
    );
  }

  void _handleGroupSelected(GroupViewModel value) {
    setState(() => _scheduleSelectionProcess.group = value.toGroup());
  }

  GroupViewModel _getSelectedGroup() {
    if (_model == null ||
        _model.groups == null ||
        _scheduleSelectionProcess.group == null) return null;

    var selectedGroup =
        _model.groups.where((x) => x.id == _scheduleSelectionProcess.group.id);
    if (selectedGroup.length == 0) return null;

    return selectedGroup.first;
  }

  List<DropdownMenuItem> _buildGroupDropdownItems() {
    return _model?.groups?.map((x) {
          return new DropdownMenuItem<GroupViewModel>(
            child: new Text(x.name),
            value: x,
          );
        })?.toList() ??
        <DropdownMenuItem<GroupViewModel>>[
          new DropdownMenuItem(
            child: new Text('Select year first'),
            value: new GroupViewModel.empty(),
          ),
        ];
  }

  Future _loadModel() async {
    if (_model != null) return;

    var instance = new GroupScreenViewModel();
    await instance.initialize();
    _model = instance;
  }

  Widget _buildInFuture(
      BuildContext buildContext, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
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
