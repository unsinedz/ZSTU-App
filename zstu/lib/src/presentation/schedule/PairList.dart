import 'package:flutter/material.dart';
import 'package:zstu/src/presentation/common/TextLocalizations.dart';
import 'package:zstu/src/resources/Sizes.dart';
import 'package:zstu/src/resources/Colors.dart';
import 'PairViewModel.dart';

class PairList extends StatefulWidget {
  PairList(this._pairs);

  final List<PairViewModel> _pairs;

  @override
  State<StatefulWidget> createState() => new _PairListState(_pairs);
}

class _PairListState extends State<PairList> with TextLocalizations {
  _PairListState(this._pairs);

  List<PairViewModel> _pairs;

  @override
  Widget build(BuildContext context) {
    if (_pairs?.length == 0 ?? true) return _buildDayOff();

    return new AnimatedList(
      itemBuilder: _buildItem,
      initialItemCount: _pairs.length,
    );
  }

  Widget _buildDayOff() {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Image.asset('assets/common/day_off.png'),
        new Container(
          margin: new EdgeInsets.only(top: Sizes.DayOffTextMargin),
          child: Text(texts.scheduleDayOff),
        ),
      ],
    );
  }

  Widget _buildSpecificDate(String date) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
            new Radius.circular(Sizes.PairListSpecificDateBorderRadius)),
        color: AppColors.PairRowThumbnail,
      ),
      padding: new EdgeInsets.symmetric(
          horizontal: Sizes.PairListSpecificDatePadding,
          vertical: Sizes.PairListSpecificDatePadding),
      margin:
          new EdgeInsets.symmetric(vertical: Sizes.PairListSpecificDateSpacing),
      child: new Text(
        date,
        style: new TextStyle(fontSize: Sizes.PairListSpecificDateTextSize),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    var item = _pairs[index];
    return _buildItemWrapper(
      item,
      new Container(
        color: item.isAdded ? AppColors.PairRowAddedBackground : null,
        child: new ListTile(
          key: new Key(item.id),
          onTap: () => this._handleItemClick(item),
          title: _buildItemContent(item),
        ),
      ),
    );
  }

  Widget _buildItemWrapper(PairViewModel item, Widget child) {
    if (item.isAdded) {
      return new Column(
        children: <Widget>[
          new Flexible(
            flex: 0,
            child: _buildSpecificDate(item.specificDate),
          ),
          new Flexible(
            flex: 0,
            child: child,
          ),
        ],
      );
    }

    if (item.hasReplacement) {
      return new Column(
        children: <Widget>[
          new Flexible(
            flex: 0,
            child: _buildReplacementArrow(),
          ),
          new Flexible(
            flex: 0,
            child: child,
          ),
        ],
      );
    }

    return child;
  }

  Widget _buildReplacementArrow() {
    return new Icon(Icons.arrow_upward);
  }

  Widget _buildItemContent(PairViewModel item) {
    return new Container(
      padding: new EdgeInsets.symmetric(
        vertical: Sizes.PairListRowSpacing,
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            margin:
                new EdgeInsets.only(right: Sizes.PairListRowThumbnailMargin),
            child: new CircleAvatar(
              backgroundColor: item.isRemoved
                  ? AppColors.PairRowRemovedFade
                  : AppColors.PairRowThumbnail,
              radius: Sizes.PairListRowThumbnailRadius,
            ),
          ),
          new Expanded(
            child: new Table(
              columnWidths: {
                1: new IntrinsicColumnWidth(),
              },
              children: <TableRow>[
                new TableRow(
                  children: <TableCell>[
                    new TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.centerLeft,
                            child: new Text(
                              item.name,
                              style: new TextStyle(
                                color: item.isAdded
                                    ? AppColors.PairRowAddedNameText
                                    : item.isRemoved
                                        ? AppColors.PairRowRemovedNameText
                                        : AppColors.PairRowNameText,
                                fontSize: Sizes.PairListRowNameSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          new Container(
                            alignment: Alignment.centerLeft,
                            margin: new EdgeInsets.symmetric(
                              vertical: Sizes.PairListRowTextSpacing,
                            ),
                            child: new Text(item.teacher,
                                style: new TextStyle(
                                  color: item.isAdded
                                      ? AppColors.PairRowAddedTeacherText
                                      : item.isRemoved
                                          ? AppColors.PairRowRemovedTeacherText
                                          : AppColors.PairRowTeacherText,
                                  fontSize: Sizes.PairListRowTeacherSize,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                    ),
                    new TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child: new Align(
                        alignment: Alignment.topRight,
                        child: _buildPairNumber(item),
                      ),
                    ),
                  ],
                ),
                new TableRow(
                  children: <TableCell>[
                    new TableCell(
                      child: new Container(
                        alignment: Alignment.bottomLeft,
                        child: new Text(
                          "${item.room} ${item.type}",
                          style: new TextStyle(
                            color: item.isAdded
                                ? AppColors.PairRowAddedRoomText
                                : item.isRemoved
                                    ? AppColors.PairRowRemovedRoomText
                                    : AppColors.PairRowRoomText,
                            fontSize: Sizes.PairListRowRoomSize,
                          ),
                        ),
                      ),
                    ),
                    new TableCell(
                      child: new Container(
                        alignment: Alignment.bottomRight,
                        child: new Text(
                          item.time,
                          style: new TextStyle(
                            color: item.isAdded
                                ? AppColors.PairRowAddedTimeText
                                : item.isRemoved
                                    ? AppColors.PairRowRemovedTimeText
                                    : AppColors.PairRowTimeText,
                            fontWeight: FontWeight.w500,
                            fontSize: Sizes.PairListRowTimeSize,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPairNumber(PairViewModel item) {
    return new Container(
      child: new InkWell(
        onTap: null,
        radius: Sizes.PairListRowNumberRadius,
        child: new Container(
          width: Sizes.PairListRowNumberRadius * 2,
          height: Sizes.PairListRowNumberRadius * 2,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: item.isAdded
                ? AppColors.PairRowAddedNumberDecoration
                : item.isRemoved
                    ? AppColors.PairRowRemovedNumberDecoration
                    : AppColors.PairRowNumberDecoration,
          ),
          child: new Center(
            child: new Text(
              item.number.toString(),
              style: new TextStyle(
                color: item.isAdded
                    ? AppColors.PairRowAddedNumberText
                    : item.isRemoved
                        ? AppColors.PairRowRemovedNumberText
                        : AppColors.PairRowNumberText,
                fontSize: Sizes.PairListRowNumberTextSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleItemClick(PairViewModel item) {}
}
