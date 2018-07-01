import 'dart:collection';
import 'package:zstu/src/domain/common/descriptors/IValueDescriptor.dart';

class ValueDescriptorFactory {
  static ValueDescriptorFactory _instance;
  static ValueDescriptorFactory get instance =>
      _instance = _instance ?? new ValueDescriptorFactory();

  Map<String, IValueDescriptor> _namedDescriptors =
      new HashMap<String, IValueDescriptor>(
          equals: (a, b) => a.toLowerCase() == b.toLowerCase());

  void registerValueDescriptor(String type, IValueDescriptor valueDescriptor) {
    if (type?.isEmpty ?? true)
      throw new ArgumentError('Type is not specified.');

    if (valueDescriptor == null)
      throw new ArgumentError('Value descriptor is null.');

    if (_namedDescriptors.containsKey(type))
      throw new ArgumentError(
          'Editor was already registered for the type "$type".');

    _namedDescriptors[type] = valueDescriptor;
  }

  IValueDescriptor getValueDescriptor(String type) {
    if (!_namedDescriptors.containsKey(type))
      throw new StateError('Editor was not registered for the type "$type".');

    return _namedDescriptors[type];
  }

  IValueDescriptor safeGetValueDescriptor(String type) {
    try {
      return getValueDescriptor(type);
    } on StateError {
      return null;
    }
  }
}
