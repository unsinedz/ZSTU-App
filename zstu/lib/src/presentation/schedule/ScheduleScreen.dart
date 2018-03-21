import 'dart:math';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/sizes.dart';
import '../../resources/values.dart';
import '../common/TextLocalizations.dart';
import 'PairViewModel.dart';
import 'PairList.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => new _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin, TextLocalizations {
  TabController _tabController;

  static const TabsCount = 6;

  int _selectedWeek = 1;
  bool animateWeekDeselection = false;

  AnimationController _weekChangeAnimationController;
  Animation<double> _weekSelectionAlphaAnimation;

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
    )
        .animate(_weekChangeAnimationController)
          ..addListener(() => this.setState(() {}));

    _weekChangeAnimationController.forward();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new TabBarView(
        controller: _tabController,
        children: _getTabBodies(),
      ),
    );
  }

  List<Widget> _getTabBodies() {
    return <Widget>[
      new PairList(_getMondayPairs()),
      new Center(child: new Text("Tuesday tab")),
      new Center(child: new Text("Wednesday tab")),
      new Center(child: new Text("Thursday tab")),
      new Center(child: new Text("Friday tab")),
      new Center(child: new Text("Saturday tab")),
    ];
  }

  List<PairViewModel> _getMondayPairs() {
    return <PairViewModel>[
      new PairViewModel(
        "Oideeshneek pervoi pary",
        1,
        "Програмування - 1. Основи програмування",
        "Крамар Ю. М.",
        "432",
        "лекція",
        "8:30-9:50",
      ),
      new PairViewModel(
        "Oideeshneek wtoroi pary",
        2,
        "Іноземна мова - 1. Вступ до загальнотехнічної іноземної мови",
        "Соколова Л. Ф.",
        "411",
        "практика",
        "10:00-11:20",
      ),
      new PairViewModel("Oideeshneek tretyei pary", 3, "Фізика",
          "Якуніна Н. О.", "312", "практика", "11:40-13:00",
          isAdded: true, specificDate: "March, 03"),
      new PairViewModel(
        "Oideeshneek tchetviortoi pary",
        3,
        "Фізика",
        "Якуніна Н. О.",
        "312",
        "практика",
        "13:30-14:50",
        isRemoved: true,
        hasReplacement: true,
      ),
    ];
  }

  Widget _buildAppBar() {
    return new AppBar(
      iconTheme: new IconThemeData(
        color: AppColors.ToolIcon,
      ),
      title: new Text(
        texts.scheduleTitle,
        style: new TextStyle(
          color: AppColors.ScreenTitle,
        ),
      ),
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
        ],
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
