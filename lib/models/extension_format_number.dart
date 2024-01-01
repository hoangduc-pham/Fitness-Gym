import 'package:intl/intl.dart';

extension FormatDateTimeExtension on num {
  String formatNumber() {
    return  NumberFormat.decimalPattern().format(this);
  }

}
