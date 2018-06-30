class Event {
  Event(this._name, {this.arguments});

  String _name;
  String get name => _name;

  List<Object> arguments;
}
