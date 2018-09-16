import 'package:flutter/material.dart';
import 'package:zstu/src/presentation/Navbar.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/resources/Colors.dart';
import 'package:zstu/src/resources/Sizes.dart';

abstract class BaseScreenMixin extends TextLocalizations {
  Widget wrapMaterialLayout({
    @required Widget content,
    @required AppBar appBar,
    Widget drawer,
    FloatingActionButton floatingActionButton,
  }) {
    return new Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: content,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget buildAppBar(String title,
      {List<Widget> actions, PreferredSizeWidget bottom}) {
    return new AppBar(
      iconTheme: new IconThemeData(
        color: AppColors.ToolIcon,
      ),
      title: new Text(
        title,
        style: new TextStyle(
          color: AppColors.ScreenTitle,
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget buildNavigationDrawer() {
    return new Navbar();
  }

  Widget noConnection(String text) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.signal_cellular_connected_no_internet_4_bar,
          size: Sizes.StandardIconSize,
        ),
        new Text(
          text,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: Sizes.FacultyAbsenceMessageTextSize,
            color: AppColors.FacultyAbsenceMessageText,
          ),
        ),
      ],
    );
  }

  Widget loadingSpinner({String text}) {
    Widget child;
    if (text != null) {
      child = new Column(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(text),
        ],
      );
    } else
      child = new CircularProgressIndicator();

    return new Center(child: child);
  }

  Widget error({String text}) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Icon(Icons.error),
        new Text(text ?? texts.somethingWentWrong),
      ],
    );
  }
}
