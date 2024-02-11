import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_fish_tank_settings.freezed.dart';
part 'smart_fish_tank_settings.g.dart';

@freezed
class SmartFishTankSettings with _$SmartFishTankSettings {
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
}
