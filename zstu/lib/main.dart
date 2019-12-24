import 'package:flutter/widgets.dart';
import 'package:zstu/Application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var app = new ZstuApp();
  await app.initialize();
  runApp(app);
}
