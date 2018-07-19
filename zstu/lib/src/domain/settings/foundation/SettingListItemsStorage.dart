import 'ISettingListItem.dart';

class SettingListItemsStorage {
  static SettingListItemsStorage _instance;
  static SettingListItemsStorage get instance =>
      _instance = _instance ?? new SettingListItemsStorage();

  List<ISettingListItem> _itemsStorage;
  List<ISettingListItem> get _items => _itemsStorage = _itemsStorage ?? [];

  bool _itemsAreSimilar(ISettingListItem item1, ISettingListItem item2) {
    if (item1 == null && item2 == null) return true;

    if (item1 == null || item2 == null) return false;

    return item1.type == item2.type && item1.name == item2.name;
  }

  void addItem(ISettingListItem item) {
    if (item == null) throw new ArgumentError('Item is null.');

    if (_items.where((x) => _itemsAreSimilar(x, item)).length > 0)
      throw new StateError('Similar item has already been added.');

    _items.add(item);
  }

  void addItems(List<ISettingListItem> items) {
    if (items == null) throw new ArgumentError('Items collection is null.');

    items.forEach(addItem);
  }

  void removeItem(ISettingListItem item) {
    if (item == null) throw new ArgumentError('Item is null.');

    if (_items.where((x) => _itemsAreSimilar(x, item)).length == 0)
      throw new StateError('Similar item has not been added yet.');

    _items.removeWhere((x) => _itemsAreSimilar(x, item));
  }

  List<ISettingListItem> getItems() {
    var result = <ISettingListItem>[];
    result.addAll(_items);
    return result;
  }
}
