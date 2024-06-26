import '../../generated/l10n.dart';

extension DurationExt on Duration {
  String format() {
    String negativeSign = isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int minLast = inMinutes.remainder(60).abs();

    if (minLast == 0) {
      return '$inHours${S.current.hour}';
    }
    
    return "$negativeSign${twoDigits(inHours)}:${twoDigits(minLast)}";
  }
}
