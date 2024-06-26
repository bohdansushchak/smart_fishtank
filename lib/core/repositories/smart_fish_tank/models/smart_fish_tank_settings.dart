import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/time_of_day_extension.dart';

part 'smart_fish_tank_settings.freezed.dart';
part 'smart_fish_tank_settings.g.dart';

@freezed
class SmartFishTankSettings with _$SmartFishTankSettings {
  const SmartFishTankSettings._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SmartFishTankSettings({
    SmartFishTankSocketSettings? socket1,
    SmartFishTankSocketSettings? socket2,
    SmartFishTankSocketSettings? socket3,
    SmartFishTankSocketSettings? socket4,
  }) = _SmartFishTankSettings;

  factory SmartFishTankSettings.fromJson(Map<String, dynamic> json) =>
      _$SmartFishTankSettingsFromJson(json);
}

enum SocketType {
  light,
  uv,
  co2,
  airPump,
}

@freezed
class SmartFishTankSocketSettings with _$SmartFishTankSocketSettings {
  const SmartFishTankSocketSettings._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SmartFishTankSocketSettings({
    required SocketType type,
    required int fromHourUtc,
    required int fromMinUtc,
    required int toHourUtc,
    required int toMinUtc,
  }) = _SmartFishTankSocketSettings;

  factory SmartFishTankSocketSettings.fromJson(Map<String, dynamic> json) =>
      _$SmartFishTankSocketSettingsFromJson(json);

  TimeOfDay get timeFromUtc => TimeOfDay(hour: fromHourUtc, minute: fromMinUtc);

  TimeOfDay get timeToUtc => TimeOfDay(hour: toHourUtc, minute: toMinUtc);

  TimeOfDay get timeFromLocal => TimeOfDayExt.fromUtc(fromHourUtc, fromMinUtc);

  TimeOfDay get timeToLocal => TimeOfDayExt.fromUtc(toHourUtc, toMinUtc);

  Duration get duration => timeFromUtc.difference(timeToUtc);
}
