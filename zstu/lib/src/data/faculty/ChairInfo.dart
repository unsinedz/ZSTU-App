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
    assert(map != null);

    id = map["id"].toString();
    name = map["name"];
  }

  ChairInfo.fromChair(Chair chair) {
    assert(chair != null);

    id = chair.id;
    name = chair.name;
  }
}
