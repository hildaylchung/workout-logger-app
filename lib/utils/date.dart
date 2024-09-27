// Package imports:
import 'package:intl/intl.dart';

String displayDateYYYYMMDDHHMM(DateTime t) {
  final f = DateFormat('yyyy-MM-dd hh:mm');
  return f.format(t);
}
