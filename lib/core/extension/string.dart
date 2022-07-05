import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime toDateTime({String format = 'yyyy/MM/dd HH:mm'}) {
    return DateFormat(format).parse(this);
  }
}
