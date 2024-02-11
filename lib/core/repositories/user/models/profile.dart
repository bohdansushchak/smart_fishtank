import 'package:freezed_annotation/freezed_annotation.dart';

import 'my_fish_tank.dart';

part 'profile.freezed.dart';

part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Profile({
    String? firstName,
    String? lastName,
    List<MyFishTank>? myFishTanks,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
