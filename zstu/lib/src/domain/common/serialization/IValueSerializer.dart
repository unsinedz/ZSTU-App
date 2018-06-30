abstract class IValueSerializer {
  String serialize(dynamic value);
  dynamic deserialize(String rawValue);
}