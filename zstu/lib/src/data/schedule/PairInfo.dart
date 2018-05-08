import '../../domain/schedule/Pair.dart';
import '../common/IPersistableEntity.dart';

class PairInfo implements IPersistableEntity {
  PairInfo.fromPair(this._pair);

  PairInfo.fromMap(Map<String, dynamic> map) {
    _pair = new Pair(
      id: map["id"],
      name: map["name"],
      teacher: map["teacher"],
      room: map["room"],
      type: map["type"],
      time: map["time"],
    );
  }

  Pair _pair;

  String get id => _pair.id;

  String get name => _pair.name;

  String get teacher => _pair.teacher;

  String get room => _pair.room;

  String get type => _pair.type;

  String get time => _pair.time;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "teacher": teacher,
      "room": room,
      "type": type,
      "time": time,
    };
  }

  Pair toPair() => _pair;
}

// TODO: check if SQLite supports date-time
