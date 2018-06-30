import 'package:zstu/src/core/locale/ILocaleProvider.dart';
import 'package:zstu/src/domain/common/text/ILocaleSensitive.dart';
import '../../domain/common/text/ITextProcessor.dart';

class TextProcessor implements ITextProcessor {
  TextProcessor(this._localeProvider);

  final ILocaleProvider _localeProvider;

  @override
  void process(ILocaleSensitive object) {
    assert(object != null);
    object.initializeForLocale(_localeProvider.getApplicationLocale());
  }
}
