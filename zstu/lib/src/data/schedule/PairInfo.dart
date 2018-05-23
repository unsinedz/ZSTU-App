import '../../domain/schedule/Pair.dart';
import '../common/IPersistableEntity.dart';

class PairInfo implements IPersistableEntity {
  PairInfo.fromPair(Pair pair) {
    if (pair == null) throw new ArgumentError('Pair is null.');
    this._pair = pair;
  }

  PairInfo.fromMap(Map<String, dynamic> map) {
    _pair = new Pair(
      id: map["id"].toString(),
      name: map["subject"].toString(),
      teacher: map["teacher"].toString(),
      room: map["room"].toString(),
      type: map["type"].toString(),
      day: map["day"].toString(),
      time: map["time"].toString(),
      number: map["number"],
    );
  }

  Pair _pair;

  String get id => _pair.id;
  String get name => _pair.name;
  String get teacher => _pair.teacher;
  String get room => _pair.room;
  String get type => _pair.type;
  String get time => _pair.time;
  int get number => _pair.number;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "teacher": teacher,
      "room": room,
      "type": type,
      "time": time,
      "number": number,
    };
  }

  Pair toPair() => _pair;
}

// TODO: check if SQLite supports date-time
