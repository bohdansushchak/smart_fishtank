import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_state.dart';

import 'smart_fish_tank_settings.dart';

part 'smart_fish_tank.freezed.dart';

part 'smart_fish_tank.g.dart';

@freezed
class SmartFishTank with _$SmartFishTank {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SmartFishTank({
    SmartFishTankSettings? settings,
    SmartFishTankState? state,
  }) = _SmartFishTank;

  factory SmartFishTank.fromJson(Map<String, dynamic> json) =>
      _$SmartFishTankFromJson(json);
}
