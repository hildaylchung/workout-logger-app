// Package imports:
import 'package:intl/intl.dart';

String displayDateYYYYMMDDHHMM(DateTime t) {
  final f = DateFormat('yyyy-MM-dd hh:mm a');
  return f.format(t);
}
