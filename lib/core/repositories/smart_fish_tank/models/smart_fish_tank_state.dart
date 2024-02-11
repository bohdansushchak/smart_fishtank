import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_fish_tank_state.freezed.dart';

part 'smart_fish_tank_state.g.dart';

@freezed
class SmartFishTankState with _$SmartFishTankState {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SmartFishTankState({
    SocketState? socket1,
    SocketState? socket2,
    SocketState? socket3,
    SocketState? socket4,
  }) = _SmartFishTankState;

  factory SmartFishTankState.fromJson(Map<String, dynamic> json) =>
      _$SmartFishTankStateFromJson(json);
}

@freezed
class SocketState with _$SocketState {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SocketState({
    required bool isOn,
    bool? force,
  }) = _SocketState;

  factory SocketState.fromJson(Map<String, dynamic> json) =>
      _$SocketStateFromJson(json);
}
