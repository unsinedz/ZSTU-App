import '../../domain/faculty/Year.dart';
import '../common/IPersistableEntity.dart';

class YearInfo implements IPersistableEntity {
  YearInfo(this.id, this.name);

  String id;
  String name;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  YearInfo.fromMap(Map<String, dynamic> map) {
    if (map == null)
      throw new ArgumentError("Map is null.");

    id = map["id"].toString();
    name = map["name"];
  }

  YearInfo.fromYear(Year year) {
    if (year == null)
      throw new ArgumentError("Year is null.");

    id = year.id;
    name = year.name;
  }
}
