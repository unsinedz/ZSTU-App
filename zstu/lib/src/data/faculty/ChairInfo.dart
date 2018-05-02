import '../../domain/faculty/Chair.dart';

class ChairInfo {
  ChairInfo(this.id, this.name);

  String id;
  String name;

  Map toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  ChairInfo.fromMap(Map<String, dynamic> map) {
    if (map == null)
      throw new ArgumentError("Map is null.");

    id = map["id"].toString();
    name = map["name"];
  }

  ChairInfo.fromChair(Chair chair) {
    if (chair == null)
      throw new ArgumentError("Chair is null.");

    id = chair.id;
    name = chair.name;
  }
}
