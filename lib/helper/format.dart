import 'package:intl/intl.dart';

class Format {
  static String? number(int value, [int decimal = 0]) {
    final number = NumberFormat.decimalPercentPattern(
        locale: null, decimalDigits: decimal);
    return number.format(value);
  }

  static String? currency(int value, [String symbol = '', int decimal = 0]) {
    final number = NumberFormat.currency(
        locale: null, decimalDigits: decimal, symbol: symbol);
    return number.format(value);
  }

  static String? dateTime(String value, EnumDateTime type) {
    DateTime convertedDate = DateTime.parse(value);
    return DateFormat(type.value).format(convertedDate);
  }
}

enum EnumDateTime {
  day,
  month,
  year,
  hours,
  minutes,
  time1,
  time2,
  dateShort1,
  dateShort2,
  dateLong1,
  dateLong2,
  dateTime1,
  dateTime2
}

extension EnumADateTimeExtension on EnumDateTime {
  String get value {
    switch (this) {
      case EnumDateTime.day:
        return 'EEEE';
      case EnumDateTime.month:
        return 'MMMM';
      case EnumDateTime.year:
        return 'yyyy';
      case EnumDateTime.hours:
        return 'HH';
      case EnumDateTime.minutes:
        return 'mm';
      case EnumDateTime.time1:
        return 'H:mm';
      case EnumDateTime.time2:
        return 'HH:mm';
      case EnumDateTime.dateShort1:
        return 'dd/mm/yyyy';
      case EnumDateTime.dateShort2:
        return 'dd MMM yyyy';
      case EnumDateTime.dateLong1:
        return 'EEEE, dd MMMM yyyy';
      case EnumDateTime.dateLong2:
        return 'dd MMMM yyyy, EEEE';
      case EnumDateTime.dateTime1:
        return 'dd MMM yyyy • H:mm';
      case EnumDateTime.dateTime2:
        return 'dd, MMM yyyy • H:mm';
    }
  }
}
