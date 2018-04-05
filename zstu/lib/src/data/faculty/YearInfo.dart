import '../../domain/faculty/Year.dart';

class YearInfo {
  YearInfo(this.id, this.name);

  String id;
  String name;

  Map toMap() {
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
