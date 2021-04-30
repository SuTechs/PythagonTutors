import 'package:intl/intl.dart';

String getFormattedTime(DateTime dateTime) {
  return DateFormat('MMM d h${dateTime.minute != 0 ? ':mm' : ''} a')
      .format(dateTime);
}
