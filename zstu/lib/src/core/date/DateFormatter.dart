class DateFormatter {
  static const String DateStringFormat = "{year}-{month}-{day}";

  static String _twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0$n";
  }

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String toDateString(DateTime date) {
    return DateStringFormat
        .replaceAll("{year}", _fourDigits(date.year))
        .replaceAll("{month}", _twoDigits(date.month))
        .replaceAll("{day}", _twoDigits(date.day));
  }
}
