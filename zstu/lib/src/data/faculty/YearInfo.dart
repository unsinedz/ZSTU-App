import '../../domain/faculty/Year.dart';
import '../common/IPersistableEntity.dart';

class YearInfo implements IPersistableEntity {
  YearInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) throw new ArgumentError("Map is null.");

    _year = new Year(
      id: map["id"].toString(),
      name: map["name"],
    );
  }

  YearInfo.fromYear(Year year) {
    if (year == null) throw new ArgumentError("Year is null.");
    this._year = year;
  }

  Year _year;

  String get id => _year.id;
  String get name => _year.name;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
