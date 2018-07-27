import 'package:zstu/src/domain/common/descriptors/GenericDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';

class StringDescriptor extends GenericDescriptor<String> {
  StringDescriptor(List<NamedValue<String>> possibleValues) : super(possibleValues);
}
