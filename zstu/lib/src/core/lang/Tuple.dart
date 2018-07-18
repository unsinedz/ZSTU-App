import 'package:flutter/foundation.dart';

class Tuple<TItem1, TItem2> {
  Tuple({
    @required
    this.item1,
    @required
    this.item2,
  });

  final TItem1 item1;
  
  final TItem2 item2;
}
