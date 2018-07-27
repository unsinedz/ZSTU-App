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
          'Descriptor was already registered for the type "$type".');

    _namedDescriptors[type] = valueDescriptor;
  }

  IValueDescriptor getValueDescriptor(String type) {
    var result = safeGetValueDescriptor(type);
    if (result == null)
      throw new StateError('Editor was not registered for the type "$type".');

    return result;
  }

  IValueDescriptor safeGetValueDescriptor(String type) {
    return _namedDescriptors[type];
  }
}
