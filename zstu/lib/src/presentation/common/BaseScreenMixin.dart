import 'package:flutter/material.dart';

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
      title: new Text(title),
    );
  }

  Widget buildNavigationDrawer() {
    return new Drawer();
  }
}
