import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {
  static TimeOfDay fromUtc(int hourUts, int minUtc) {
    final n = DateTime.now();
    return TimeOfDay.fromDateTime(DateTime.utc(
      n.year,
      n.month,
      n.day,
      hourUts,
      minUtc,
    ).toLocal());
  }

  String hhmm() {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }

  Duration difference(TimeOfDay end) {
    final fromInMin = minute + hour * 60;
    final toInMin = end.minute + end.hour * 60;
    return Duration(minutes: toInMin - fromInMin);
  }
}
