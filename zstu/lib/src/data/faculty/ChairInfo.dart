import '../../domain/faculty/Chair.dart';

class ChairInfo {
  ChairInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) throw new ArgumentError("Map is null.");

    _chair = new Chair(
      map["Id"].toString(),
      map["name"],
    );
  }

  ChairInfo.fromChair(Chair chair) {
    if (chair == null) throw new ArgumentError("Chair is null.");
    this._chair = chair;
  }

  Chair _chair;

  String get id => _chair.id;
  String get name => _chair.name;

  Map toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
