import 'package:flutter/widgets.dart';
import 'package:zstu/Application.dart';
import 'package:zstu/src/data/DataModule.dart';

void main() async {
  await DataModule.configure();
  runApp(new ZstuApp());
}
