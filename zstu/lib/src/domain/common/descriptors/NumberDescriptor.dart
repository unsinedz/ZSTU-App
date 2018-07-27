import 'package:zstu/src/domain/common/descriptors/GenericDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';

class NumberDescriptor extends GenericDescriptor<num> {
  NumberDescriptor(List<NamedValue<num>> possibleValues) : super(possibleValues);
}
