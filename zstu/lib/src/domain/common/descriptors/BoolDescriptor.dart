import 'package:zstu/src/domain/common/descriptors/GenericDescriptor.dart';
import 'package:zstu/src/domain/common/descriptors/NamedValue.dart';

class BoolDescriptor extends GenericDescriptor<bool> {
  BoolDescriptor()
      : super([
          new NamedValue<bool>('On', true),
          new NamedValue<bool>('Off', false)
        ]);
}
