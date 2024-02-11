import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_fish_tank.freezed.dart';
part 'my_fish_tank.g.dart';

@freezed
class MyFishTank with _$MyFishTank {
  const factory MyFishTank(String name, String uid) = _MyFishTank;

  factory MyFishTank.fromJson(Map<String, dynamic> json) =>
      _$MyFishTankFromJson(json);
}