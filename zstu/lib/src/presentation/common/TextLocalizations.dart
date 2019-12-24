import 'package:flutter/material.dart';
import '../../resources/Texts.dart';

abstract class TextLocalizations {
  Texts texts;

  void initTexts(BuildContext context) {
    texts = Localizations.of<Texts>(context, Texts);
  }
}
