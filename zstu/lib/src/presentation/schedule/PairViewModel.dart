class PairViewModel {
  PairViewModel(
    this.id,
    this.number,
    this.name,
    this.teacher,
    this.room,
    this.type,
    this.time, {
    this.isAdded: false,
    this.isRemoved: false,
    this.hasReplacement: false,
    this.specificDate,
  }) : assert(id != null),
       assert(name != null),
       assert(teacher != null),
       assert(room != null),
       assert(type != null);

  String id;

  int number;

  String name;

  String teacher;

  String room;

  String type;

  String time;

  bool isAdded;

  bool isRemoved;

  bool hasReplacement;

  String specificDate;
}