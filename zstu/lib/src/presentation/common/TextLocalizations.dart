import 'package:zstu/src/App.dart';
import '../../resources/texts.dart';

abstract class TextLocalizations {
  final Texts texts = new Texts(new App().locale);
}
