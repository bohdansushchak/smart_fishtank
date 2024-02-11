import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_fishtank/core/repositories/user/models/profile.dart';
import 'package:smart_fishtank/core/repositories/user/user_repository.dart';

part 'my_fish_tanks_state.dart';

part 'my_fish_tanks_cubit.freezed.dart';

class MyFishTanksCubit extends Cubit<MyFishTanksState> {
  MyFishTanksCubit(this._userRepository) : super(MyFishTanksState.init()) {
    fetchFishTanks();
  }

  final UserRepository _userRepository;

  Future<void> fetchFishTanks() async {}

  Future<void> addFishTank(String uid, String name) async {}
}
