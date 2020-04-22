import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gtoserviceapp/services/api/api_error.dart';

class Utils {
  static String formatWidth(int value, int width) {
    return value.toString().padLeft(width, "0");
  }

  static String formatDate(DateTime date) {
    return "${formatWidth(date.day, 2)}.${formatWidth(date.month, 2)}.${date.year}";
  }

  static String dateToJson(DateTime date) {
    return "${date.year}-${formatWidth(date.month, 2)}-${formatWidth(date.day, 2)}";
  }

  static String errorToString(error) {
    if (!kReleaseMode) {
      // Debug
      return error.toString();
    }

    if (error is APIErrors) {
      return error.toText();
    } else if (error is SocketException) {
      return "Не удалось подключиться к серверу";
    } else {
      return error.toString();
    }
  }
}