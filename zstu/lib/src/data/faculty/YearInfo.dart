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
    assert(map != null);

    id = map["id"].toString();
    name = map["name"];
  }

  YearInfo.fromYear(Year year) {
    assert(year != null);

    id = year.id;
    name = year.name;
  }
}
