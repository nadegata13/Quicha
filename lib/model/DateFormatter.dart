import 'package:intl/intl.dart';

class DateFormatter{
  static DateTime dateFormatter(String dateStr){
    final _dateFormatter = DateFormat("y/M/d-HH:mm:ss");

    DateTime result;

    try {
      result = _dateFormatter.parse(dateStr);
      return result;

    } catch(e) {

      print("dateFormatter: " + e.toString());
      return DateTime.now();
    }

  }
}
