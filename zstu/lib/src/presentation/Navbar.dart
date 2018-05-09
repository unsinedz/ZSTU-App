import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../App.dart';
import '../data/Constants.dart';
import '../domain/common/IAssetManager.dart';
import 'common/TextLocalizations.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NavbarState();
}

class NavbarItem {
  const NavbarItem({
    this.text,
    this.icon,
    this.assetImage,
    this.hasDividerBefore = false,
    this.hasDividerAfter = false,
    this.onTap,
  });

  final String text;

  final IconData icon;

  // Ignored, if the icon is specified
  final String assetImage;

  bool get hasIcon => icon != null;

  final bool hasDividerBefore;

  final bool hasDividerAfter;

  final GestureTapCallback onTap;
}

class _NavbarState extends State<Navbar> with TextLocalizations {
  static List<NavbarItem> _MenuItems;

  static String get NavbarAssets => Constants.NAVBAR_ASSETS;

  IAssetManager _assets;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _assets = new App().assets;
    _scrollController = new ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initMenuItems(BuildContext context) {
    _MenuItems = <NavbarItem>[
      new NavbarItem(
        text: texts.myScheduleTitle,
        assetImage: '${NavbarAssets}mySchedule.png',
        hasDividerAfter: true,
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.facultiesTitle,
        assetImage: '${NavbarAssets}faculties.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.scheduleTitle,
        assetImage: '${NavbarAssets}schedule.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.teachersTitle,
        assetImage: '${NavbarAssets}teachers.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.newsTitle,
        assetImage: '${NavbarAssets}news.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.learnPortalTitle,
        assetImage: '${NavbarAssets}learnPortal.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.settingsTitle,
        assetImage: '${NavbarAssets}settings.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
        hasDividerBefore: true,
      ),
      new NavbarItem(
        text: texts.aboutTitle,
        assetImage: '${NavbarAssets}about.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
    ];
  }

  void _showFeatureNotAvailableMessage(BuildContext context) {
    Navigator.of(context).pop();
    var scaffold = Scaffold.of(context);
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(new SnackBar(
      content: new Text(texts.featureNotAvailable),
    ));
  }

  @override
  Widget build(BuildContext context) {
    initTexts(context);
    _initMenuItems(context);

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          _buildHeader(),
        ]..addAll(_getNavbarItems(context)),
      ),
    );
  }

  Widget _buildHeader() {
    return new DrawerHeader(
      child: new Text(''),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            _assets.getAssetPath('${NavbarAssets}header.png'),
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  List<Widget> _getNavbarItems(BuildContext context) {
    var iconSize = IconTheme.of(context).size;
    List<Widget> result = <Widget>[];

    _MenuItems.forEach((x) {
      if (x.hasDividerBefore) result.add(new Divider());

      result.add(
        new InkWell(
          onTap: x.onTap ?? () {},
          child: new ListTile(
            title: new Text(x.text),
            leading: x.hasIcon
                ? new Icon(x.icon)
                : new Image(
                    image: new AssetImage(_assets.getAssetPath(x.assetImage)),
                    width: iconSize,
                    height: iconSize,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
            dense: true,
          ),
        ),
      );

      if (x.hasDividerAfter) result.add(new Divider());
    });

    return result;
  }
}
