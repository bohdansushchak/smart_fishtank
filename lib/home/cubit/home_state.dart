part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    List<MyFishTank>? myFishTanks,
    MyFishTank? currentFishTank,
    SmartFishTank? fishTankState,
  }) = _HomeState;

  factory HomeState.init() => HomeState();
}
