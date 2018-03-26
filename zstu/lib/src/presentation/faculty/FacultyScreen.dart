import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../App.dart';
import '../../resources/Colors.dart';
import '../../resources/sizes.dart';
import '../common/BaseScreenMixin.dart';
import '../common/TextLocalizations.dart';
import 'FacultyScreenViewModel.dart';
import 'FacultyViewModel.dart';
import 'group/GroupScreen.dart';

class FacultiesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FacultiesState();
}

class _FacultiesState extends State<FacultiesScreen>
    with TextLocalizations, BaseScreenMixin {
  FacultyScreenViewModel _model;
  ScrollController _gridScrollController;
  StreamSubscription _connectivityChangeListener;
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

    super.initState();
  }

  @override
  void dispose() {
    _gridScrollController.dispose();
    _connectivityChangeListener.cancel();

    super.dispose();
  }

  Future<FacultyScreenViewModel> _getModel() async {
    if (_model != null) return new SynchronousFuture(_model);

    var instance = new FacultyScreenViewModel();
    await instance.loadFaculties();
    return _model = instance;
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);

    return wrapMaterialLayout(
        new FutureBuilder(
          future: _getModel(),
          builder: _buildInFuture,
        ),
        buildAppBar(texts.facultiesTitle),
        drawer: buildNavigationDrawer());
  }

  Widget _buildInFuture(
      BuildContext context, AsyncSnapshot<FacultyScreenViewModel> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    var model = snapshot.data;
    if (model == null || model.faculties.length == 0) {
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
            itemCount: model.faculties.length,
            itemBuilder: _buildFaculty,
            controller: _gridScrollController,
          ),
        ),
      ],
    );
  }

  void _handleFacultyTap(BuildContext context, FacultyViewModel item) {
    var scaffoldContext = Scaffold.of(context);
    scaffoldContext.removeCurrentSnackBar();
    scaffoldContext.showSnackBar(new SnackBar(
      content: new Text("${item.abbr} clicked"),
      duration: new Duration(seconds: 2),
    ));
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        return new GroupScreen(item.id);
      },
    ));
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
