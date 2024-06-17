import 'package:intl/intl.dart';

getFormattedDate() {
  return DateFormat('dd-MM-yyyy').format(DateTime.now());
}
