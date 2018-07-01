import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zstu/src/domain/event/LocalizationChangeEvent.dart';

import '../App.dart';
import '../domain/Constants.dart';
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

  bool get hasImage => assetImage != null;

  final bool hasDividerBefore;

  final bool hasDividerAfter;

  final GestureTapCallback onTap;
}

class _NavbarState extends State<Navbar> with TextLocalizations {
  static List<NavbarItem> _menuItems;

  static String get navbarAssets => Constants.NavbarAssets;

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
    _menuItems = <NavbarItem>[
      new NavbarItem(
        text: texts.myScheduleTitle,
        assetImage: '${navbarAssets}mySchedule.png',
        hasDividerAfter: true,
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.facultiesTitle,
        assetImage: '${navbarAssets}faculties.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.scheduleTitle,
        assetImage: '${navbarAssets}schedule.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.teachersTitle,
        assetImage: '${navbarAssets}teachers.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.newsTitle,
        assetImage: '${navbarAssets}news.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.learnPortalTitle,
        assetImage: '${navbarAssets}learnPortal.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
        text: texts.settingsTitle,
        assetImage: '${navbarAssets}settings.png',
        onTap: () => _pushNamed(context, '/settings'),
        hasDividerBefore: true,
      ),
      new NavbarItem(
        text: texts.aboutTitle,
        assetImage: '${navbarAssets}about.png',
        onTap: () => _showFeatureNotAvailableMessage(context),
      ),
      new NavbarItem(
          text: 'Change to russian',
          onTap: () => new App().eventBus.postEvent(
              new LocalizationChangeEvent(new Locale('ru', '')), this)),
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

  void _pushNamed(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
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
            _assets.getAssetPath('${navbarAssets}header.png'),
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  List<Widget> _getNavbarItems(BuildContext context) {
    var iconSize = IconTheme.of(context).size;
    List<Widget> result = <Widget>[];

    _menuItems.forEach((x) {
      if (x.hasDividerBefore) result.add(new Divider());

      result.add(
        new InkWell(
          onTap: x.onTap ?? () {},
          child: new ListTile(
            title: new Text(x.text),
            leading: x.hasIcon
                ? new Icon(x.icon)
                : x.hasImage
                    ? new Image(
                        image:
                            new AssetImage(_assets.getAssetPath(x.assetImage)),
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      )
                    : new Text(''),
            dense: true,
          ),
        ),
      );

      if (x.hasDividerAfter) result.add(new Divider());
    });

    return result;
  }
}
