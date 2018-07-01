import 'package:zstu/src/domain/common/descriptors/GenericDescriptor.dart';

class StringDescriptor extends GenericDescriptor<String> {
  StringDescriptor(List<String> possibleValues) : super(possibleValues);
}
