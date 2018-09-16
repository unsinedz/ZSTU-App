import 'package:flutter/widgets.dart';

abstract class ITextProvider {
  Locale get locale;

  String getText(String key);
}