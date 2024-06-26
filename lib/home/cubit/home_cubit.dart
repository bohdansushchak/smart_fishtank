import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_settings.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/smart_fish_tank_repository.dart';
import 'package:smart_fishtank/core/repositories/user/user_repository.dart';
import 'package:smart_fishtank/feature/auth/cubit/auth_cubit.dart';

import '../../core/repositories/smart_fish_tank/models/smart_fish_tank_state.dart';
import '../../core/repositories/user/models/my_fish_tank.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._authCubit,
    this._userRepository,
    this._fishTankRepository,
  ) : super(HomeState.init()) {
    fetch();
  }

  int num = 0;

  final AuthCubit _authCubit;
  final UserRepository _userRepository;
  final SmartFishTankRepository _fishTankRepository;
  StreamSubscription? _fishTankSubs;

  Future<void> fetch() async {
    final fishTanks = await _userRepository.fetchMyFishTanks();
    if (fishTanks != null) {
      emit(state.copyWith(myFishTanks: fishTanks));
      if (fishTanks.isNotEmpty) {
        setFishTank(fishTanks.first);
      }
    }
  }

  void setFishTank(MyFishTank fishTank) {
    if (fishTank == state.currentFishTank) {
      return;
    }

    emit(state.copyWith(currentFishTank: fishTank, fishTankState: null));
    _fetchFishTankState();
    _subscribeFishTankState();
  }

  Future<void> _fetchFishTankState() async {
    final current = state.currentFishTank;
    if (current == null) {
      return;
    }

    final fishTank = await _fishTankRepository.getFishTankState(current.uid);
    emit(state.copyWith(fishTankState: fishTank));
  }

  Future<void> _subscribeFishTankState() async {
    final current = state.currentFishTank;
    if (current == null) {
      return;
    }

    if (_fishTankSubs != null) {
      _fishTankSubs?.cancel();
      _fishTankSubs = null;
    }
    _fishTankSubs =
        _fishTankRepository.onChangeFishTankState(current.uid).listen((e) {
      emit(state.copyWith(fishTankState: e));
    });

    final fishTank = await _fishTankRepository.getFishTankState(current.uid);
    emit(state.copyWith(fishTankState: fishTank));
  }

  Future<void> addFishTank(String uid, String name) async {
    final tank = MyFishTank(name, uid);

    List<MyFishTank> tanks = List.of(state.myFishTanks ?? [])..add(tank);
    await _userRepository.updateMyFishTanks(tanks);
    emit(state.copyWith(myFishTanks: tanks));
    setFishTank(tank);
  }

  Future<void> setFishTankSettings() async {
    final current = state.currentFishTank;
    if (current == null) {
      return;
    }

    final st = SmartFishTankState(
      socket1: SocketState(isOn: true, force: null),
      socket2: SocketState(isOn: true, force: null),
      socket3: SocketState(isOn: true, force: null),
      socket4: SocketState(isOn: true, force: null),
    );
    _fishTankRepository.updateFishTankState(current.uid, st);

    final set = SmartFishTankSettings(
      socket1: SmartFishTankSocketSettings(
        type: SocketType.light,
        fromHourUtc: 9,
        fromMinUtc: 0,
        toHourUtc: num,
        toMinUtc: 0,
      ),
      socket2: SmartFishTankSocketSettings(
        type: SocketType.light,
        fromHourUtc: 10,
        fromMinUtc: 0,
        toHourUtc: 14,
        toMinUtc: 0,
      ),
    );
    await _fishTankRepository.updateFishTankSettings(current.uid, set);
  }

  Future<void> updateSocketConfig(
    int socketNum, {
    required TimeOfDay timeFrom,
    required TimeOfDay timeTo,
    required SocketType type,
  }) async {}
}
