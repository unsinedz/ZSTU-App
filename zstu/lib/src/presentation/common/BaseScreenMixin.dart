import 'package:flutter/material.dart';
import '../../resources/Colors.dart';

abstract class BaseScreenMixin {
  Widget wrapMaterialLayout(Widget content, AppBar appBar, {Drawer drawer}) {
    return new Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: content,
    );
  }

  Widget buildAppBar(String title, {List<Widget> actions, PreferredSizeWidget bottom}) {
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
    return new Drawer();
  }
}
