import '../../domain/schedule/Pair.dart';

class PairViewModel {
  PairViewModel.fromPair(this._pair) : assert(_pair != null);

  Pair _pair;

  String get id => _pair.id;

  int get number => _pair.number;

  String get name => _pair.name;

  String get teacher => _pair.teacher;

  String get room => _pair.room;

  String get type => _pair.type;

  String get time => _pair.time;

  bool get isAdded => false;

  bool get isRemoved => false;

  bool get hasReplacement => false;

  String specificDate;
}