import 'package:zstu/src/domain/common/descriptors/GenericDescriptor.dart';

class NumberDescriptor extends GenericDescriptor<num> {
  NumberDescriptor(List<num> possibleValues) : super(possibleValues);
}
