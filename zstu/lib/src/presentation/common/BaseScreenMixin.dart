import 'package:flutter/material.dart';

import '../../resources/Colors.dart';
import '../../resources/Sizes.dart';

abstract class BaseScreenMixin {
  Widget wrapMaterialLayout(Widget content, AppBar appBar, {Drawer drawer}) {
    return new Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: content,
    );
  }

  Widget buildAppBar(String title) {
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
    );
  }

  Widget buildNavigationDrawer() {
    return new Drawer();
  }
}
