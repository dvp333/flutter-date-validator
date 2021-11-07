library flutter_date_validator;

import 'package:flutter_date_validator/exceptions.dart';
import 'package:intl/intl.dart';

class FlutterDateValidator {

  final DateFormat dateFormat;

  static const monthsWith30Days = [4, 6, 9, 11];
  static const monthsWith31Days = [1, 3, 5, 7, 8, 10, 12];

  FlutterDateValidator({required this.dateFormat});

  bool isValid(String strDate) {
    try {
      final date = dateFormat.parse(strDate);
      return !(monthsWith30Days.contains(date.month) && date.day > 30 
        || (date.month == 2 && 
              ( isLeapYear(date.year) && date.day > 29 ||
                !isLeapYear(date.year) && date.day > 28
              )
           )
        || date.day > 31
        || date.month > 12);
    } catch (e) {
      return false;
    }
  }

  bool isUnder18(String birthDate) {
    try{
      if (!isValid(birthDate)) throw InvalidDateException();
      final date = dateFormat.parse(birthDate);
      final adultDate = DateTime(
        date.year + 18, date.month, date.day,
      );
      return adultDate.isAfter(DateTime.now());
    } catch (e) {
      throw InvalidDateException();
    }
  }

  static bool isLeapYear(int year) {
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
  }

}
