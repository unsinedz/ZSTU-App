import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../App.dart';
import '../../domain/common/process/IStep.dart';
import '../../domain/schedule/PerWeekScheduleLoadOptions.dart';
import '../../domain/schedule/ScheduleSelectionProcess.dart';
import '../../resources/colors.dart';
import '../../resources/sizes.dart';
import '../../resources/values.dart';
import '../common/BaseScreenMixin.dart';
import '../common/TextLocalizations.dart';
import 'PairList.dart';
import 'ScheduleViewModel.dart';

class ScheduleScreen extends StatefulWidget
    implements IStep<ScheduleSelectionProcess> {
  @override
  _ScheduleScreenState createState() => new _ScheduleScreenState();

  @override
  bool canBeExecuted(ScheduleSelectionProcess process) {
    return process?.faculty != null && process?.group != null;
  }
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin, BaseScreenMixin, TextLocalizations {
  TabController _tabController;

  static const List<int> PairDays = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];
  static get TabsCount => PairDays.length;

  int _selectedWeek = 1;
  bool animateWeekDeselection = false;

  AnimationController _weekChangeAnimationController;
  Animation<double> _weekSelectionAlphaAnimation;

  ScheduleSelectionProcess _scheduleSelectionProcess;

  ScheduleViewModel _model;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: TabsCount);

    _weekChangeAnimationController = new AnimationController(
        duration:
            new Duration(milliseconds: Values.WeekChangeAnimationDuration),
        vsync: this);

    _weekSelectionAlphaAnimation = new CurveTween(
      curve: Curves.easeOut,
    ).animate(_weekChangeAnimationController)
      ..addListener(() => this.setState(() {}));

    _weekChangeAnimationController.forward();
    _scheduleSelectionProcess = new App().processes.scheduleSelection;
    if (!_scheduleSelectionProcess.canExecuteStep(this.widget))
      throw new StateError("Step can not be executed.");
  }

  @override
  void dispose() {
    _tabController.dispose();
    _weekChangeAnimationController.dispose();
    super.dispose();
  }

  void _handleWeekClick(int weekNo) {
    if (_selectedWeek == weekNo) return;

    setState(() {
      animateWeekDeselection = true;
      _weekChangeAnimationController.reset();
      _selectedWeek = weekNo;
      _weekChangeAnimationController.forward();
      _model = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);
    return new FutureBuilder(
      future: _loadModel(),
      builder: _buildInFuture,
    );
  }

  Future _loadModel() async {
    if (_model != null) return null;

    var instance = new ScheduleViewModel();
    await instance
        .loadSchedule(new PerWeekScheduleLoadOptions(
          group: _scheduleSelectionProcess.group,
          weekNo: _selectedWeek,
        ))
        .catchError((e) => print('Error: $e'))
        .whenComplete(() => _model = instance);
  }

  Widget _buildInFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Scaffold(
        appBar: buildAppBar(texts.scheduleTitle),
        body: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }

    return new Scaffold(
      appBar: _buildScheduleAppBar(),
      body: new TabBarView(
        controller: _tabController,
        children: _getTabBodies(),
      ),
    );
  }

  List<Widget> _getTabBodies() {
    return PairDays.map((x) => new PairList(_model.getPairs(x))).toList();
  }

  Widget _buildScheduleAppBar() {
    return buildAppBar(
      texts.scheduleTitle,
      actions: <Widget>[
        new Container(
          margin: new EdgeInsets.only(
            right: Sizes.AppBarActionsMargin,
          ),
          child: new Row(
            children: <Widget>[
              _buildWeekSelector(1, _selectedWeek == 1),
              _buildWeekSelector(2, _selectedWeek == 2),
            ],
          ),
        ),
      ],
      bottom: new TabBar(
        indicatorColor: AppColors.TabUnderline,
        unselectedLabelColor: AppColors.UnselectedTabText,
        labelColor: AppColors.SelectedTabText,
        controller: _tabController,
        tabs: <Widget>[
          new Tab(
            text: texts.mondayShort,
          ),
          new Tab(
            text: texts.tuesdayShort,
          ),
          new Tab(
            text: texts.wednesdayShort,
          ),
          new Tab(
            text: texts.thursdayShort,
          ),
          new Tab(
            text: texts.fridayShort,
          ),
          new Tab(
            text: texts.saturdayShort,
          ),
          new Tab(
            text: texts.sundayShort,
          ),
        ].take(TabsCount).toList(),
      ),
    );
  }

  Color _getWeekSelectorColor(bool selected) {
    if (!selected) return AppColors.WeekSelectionDecorationUnselected;

    num alpha = selected
        ? _weekSelectionAlphaAnimation.value * 255
        : animateWeekDeselection
            ? (1 - _weekSelectionAlphaAnimation.value) * 255
            : 0;

    return AppColors.WeekSelectionDecorationSelected
        .withAlpha(max(alpha.round(), Values.WeekChangeIconMinimumAlpha));
  }

  Widget _buildWeekSelector(int weekNo, bool selected) {
    return new Container(
      margin: new EdgeInsets.only(
        left: Sizes.WeekSelectorIconSpacing,
      ),
      child: new InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => _handleWeekClick(weekNo),
        radius: Sizes.WeekSelectorIconRadius,
        child: new Container(
          width: Sizes.WeekSelectorIconRadius * 2,
          height: Sizes.WeekSelectorIconRadius * 2,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: _getWeekSelectorColor(selected),
          ),
          child: new Center(
            child: new Text(
              weekNo.toString(),
              style: new TextStyle(
                color: AppColors.WeekSelectionText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: week selector in seperate class
