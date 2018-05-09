import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../../App.dart';
import '../../domain/common/process/IStep.dart';
import '../../domain/schedule/ScheduleSelectionProcess.dart';
import '../../resources/Colors.dart';
import '../../resources/sizes.dart';
import '../common/BaseScreenMixin.dart';
import '../common/TextLocalizations.dart';
import 'FacultyScreenViewModel.dart';
import 'FacultyViewModel.dart';

class FacultiesScreen extends StatefulWidget
    implements IStep<ScheduleSelectionProcess> {
  @override
  State<StatefulWidget> createState() => new _FacultiesState();

  @override
  bool canBeExecuted(ScheduleSelectionProcess process) {
    return true;
  }
}

class _FacultiesState extends State<FacultiesScreen>
    with TextLocalizations, BaseScreenMixin {
  FacultyScreenViewModel _model;
  ScrollController _gridScrollController;
  StreamSubscription _connectivityChangeListener;
  ScheduleSelectionProcess _scheduleSelectionProcess;
  App _app;

  @override
  void initState() {
    _gridScrollController = new ScrollController();
    _app = new App();
    _connectivityChangeListener =
        new Connectivity().onConnectivityChanged.listen((r) {
      if (r != ConnectivityResult.none &&
          (_model?.faculties?.length ?? -1) == 0) setState(() => _model = null);
    });
    
    _scheduleSelectionProcess = _app.processes.scheduleSelection;
    if (!_scheduleSelectionProcess.canExecuteStep(widget))
      throw new StateError("Step can not be executed.");

    super.initState();
  }

  @override
  void dispose() {
    _gridScrollController.dispose();
    _connectivityChangeListener.cancel();

    super.dispose();
  }

  Future _loadModel() async {
    if (_model != null) return null;

    var instance = new FacultyScreenViewModel();
    await instance.initialize();
    _model = instance;
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);

    return wrapMaterialLayout(
        new FutureBuilder(
          future: _loadModel(),
          builder: _buildInFuture,
        ),
        buildAppBar(texts.facultiesTitle),
        drawer: buildNavigationDrawer());
  }

  Widget _buildInFuture(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError)
      print(snapshot.error);

    if (_model == null && snapshot.connectionState != ConnectionState.done) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    if (_model == null || _model.faculties.length == 0) {
      return new Center(
        child: new Text(
          texts.noFacultiesStored,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: Sizes.FacultyAbsenceMessageTextSize,
            color: AppColors.FacultyAbsenceMessageText,
          ),
        ),
      );
    }

    return new Column(
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.symmetric(
              vertical: Sizes.FacultiesGridTitleSpacing),
          child: new Text(
            texts.facultiesGridTitle,
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Sizes.FacultiesGridTitleTextSize,
            ),
          ),
        ),
        new Flexible(
          flex: 1,
          child: new GridView.builder(
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Sizes.FacultiesGridMaxExtent,
              childAspectRatio: Sizes.FacultiesGridItemAspectRatio,
              mainAxisSpacing: Sizes.FacultiesGridSpacing,
            ),
            itemCount: _model.faculties.length,
            itemBuilder: _buildFaculty,
            controller: _gridScrollController,
          ),
        ),
      ],
    );
  }

  void _handleFacultyTap(BuildContext context, FacultyViewModel item) {
    _scheduleSelectionProcess.faculty = item.toFaculty();
    Navigator.of(context).pushNamed("/group");
  }

  Widget _buildFaculty(BuildContext context, int index) {
    var item = _model.faculties[index];
    return new Builder(builder: (BuildContext context) {
      return new InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => _handleFacultyTap(context, item),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildFacultyImage(item),
              new Container(
                margin: new EdgeInsets.only(
                    top: Sizes.FacultiesGridItemTextSpacing),
                child: new Text(
                  item.abbr,
                  style: new TextStyle(
                    fontSize: Sizes.FacultiesGridItemTextSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFacultyImage(FacultyViewModel item) {
    return new CircleAvatar(
      radius: Sizes.FacultiesGridImageRadius,
      backgroundColor: Colors.blue[100],
      backgroundImage: item.image == null
          ? null
          : new AssetImage(_app.assets.getAssetPath(item.image)),
    );
  }
}
