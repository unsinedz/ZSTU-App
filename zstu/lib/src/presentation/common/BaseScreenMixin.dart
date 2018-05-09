import 'package:flutter/material.dart';
import '../../resources/Colors.dart';
import '../../resources/Sizes.dart';
import '../Navbar.dart';

abstract class BaseScreenMixin {
  Widget wrapMaterialLayout(Widget content, AppBar appBar, {Widget drawer}) {
    return new Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: content,
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
    return new Center(
      child: new Text(
        text,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: Sizes.FacultyAbsenceMessageTextSize,
          color: AppColors.FacultyAbsenceMessageText,
        ),
      ),
    );
  }
}
