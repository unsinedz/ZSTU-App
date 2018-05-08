import 'Pair.dart';

class Schedule {
  Schedule({
    this.weekNo,
    this.weekPairs,
  });

  int weekNo;

  Map<int, List<Pair>> weekPairs;
}
