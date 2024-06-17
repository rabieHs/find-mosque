import 'package:intl/intl.dart';

getFormattedDate({int offsetDays = 0}) {
  return DateFormat('dd-MM-yyyy')
      .format(DateTime.now().add(Duration(days: offsetDays)));
}
