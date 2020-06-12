class AppUtils{
  static String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  static String getMonthStringFull(int value) {
    if (value == 1) {
      return 'January';
    }
    if (value == 2) {
      return 'Febuary';
    }
    if (value == 3) {
      return 'March';
    }
    if (value == 4) {
      return 'April';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'June';
    }
    if (value == 7) {
      return 'July';
    }
    if (value == 8) {
      return 'August';
    }
    if (value == 9) {
      return 'September';
    }
    if (value == 10) {
      return 'October';
    }
    if (value == 11) {
      return 'November';
    }
    if (value == 12) {
      return 'December';
    }
    return value.toString();
  }

  static String getDate(DateTime time) {
    return "${addLeadingZeroIfNeeded(time.hour)}:"
        "${addLeadingZeroIfNeeded(time.minute)} ${getMonthStringFull(time.month)} ${addLeadingZeroIfNeeded(time.day)}";
  }
  static String getDate2(DateTime time) {
    return "${getMonthStringFull(time.month)} ${addLeadingZeroIfNeeded(time.day)}, ${addLeadingZeroIfNeeded(time.hour)}:${addLeadingZeroIfNeeded(time.minute)}";
  }
}