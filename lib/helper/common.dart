import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Common {
  static String? numberFormat(int? value) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return formatCurrency.format(value);
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static String getType(String type) {
    switch (type) {
      case 'DATE_SQL':
        return 'yyyy-MM-dd';
      case 'VERY_SHORT':
        return 'dd/MM/yyyy';
      case 'SHORT':
        return 'dd MMM yyyy';
      case 'LONG':
        return 'EEEE, dd MMMM yyyy';
      case 'MONTH_YEAR':
        return 'MMM yyyy';
      case 'DAY':
        return 'EEEE';
      case 'DATE':
        return 'dd';
      case 'MONTH':
        return 'MMMM';
      case 'TIME':
        return 'H:mm';
      case 'TIME_24':
        return 'HH:mm';
      case 'SHORT_WITH_TIME':
        return 'dd MMM yyyy • H:mm';
      default:
        return '';
    }
  }

  static String? dateFormat(String value, String type) {
    DateTime dateTimeFromString = DateTime.parse(value);
    return DateFormat(getType(type)).format(dateTimeFromString);
  }

  static String parseUrlParams(Map<String, dynamic>? urlParams) {
    if (urlParams == null) return '';
    if (urlParams.isEmpty) return '';
    String combinedParams = '';
    for (String key in urlParams.keys) {
      if (combinedParams == '') {
        combinedParams = '?$key=${urlParams[key]}';
      } else {
        combinedParams = '$combinedParams&$key=${urlParams[key]}';
      }
    }
    return combinedParams;
  }

  static String getImage(List<dynamic> imgList, String type) {
    for (Map<String, dynamic> img in imgList) {
      if (img['type'] == type) {
        return img['image3x'] ?? '';
      }
    }
    return '';
  }

  static String extensionRegex({required String path}) {
    RegExp regExp = RegExp(r'\.([a-zA-Z0-9]+)$');
    Match? match = regExp.firstMatch(path);
    String? extension = match?.group(1);
    return extension ?? '';
  }
}
