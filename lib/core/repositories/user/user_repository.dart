import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_fishtank/core/repositories/user/models/profile.dart';

import 'models/my_fish_tank.dart';

class UserRepository {
  final FirebaseAuth _fbAuth;
  final FirebaseDatabase _fbDatabase;

  UserRepository(this._fbAuth, this._fbDatabase);

  Future<Profile?> fetchMyProfile() async {
    final user = _fbAuth.currentUser;
    if (user == null) {
      return null;
    }

    final res = await _fbDatabase.ref('users/${user.uid}').get();
    if (!res.exists) {
      return null;
    }

    print(res.value.runtimeType);
    // return Profile.fromJson(res.value as Map<String, dynamic>);
  }

  Future<List<MyFishTank>?> fetchMyFishTanks() async {
    final user = _fbAuth.currentUser;
    if (user == null) {
      return null;
    }

    final res = await _fbDatabase.ref('users/${user.uid}/myFishTanks').get();
    if (!res.exists || res.value == null) {
      return null;
    }

    final list = res.value as List;
    return list.map((e) {
      final value = Map<String, dynamic>.from(e as Map<Object?, Object?>);
      return MyFishTank.fromJson(value);
    }).toList();
  }

  Future<void> updateProfile(Profile profile) async {
    final user = _fbAuth.currentUser;
    if (user == null) {
      return;
    }

    await _fbDatabase.ref('users/${user.uid}').set(profile.toJson());
  }

  Future<void> updateMyFishTanks(List<MyFishTank> tanks) async {
    final user = _fbAuth.currentUser;
    if (user == null) {
      return;
    }

    await _fbDatabase
        .ref('users/${user.uid}/myFishTanks')
        .set(tanks.map((e) => e.toJson()).toList());
  }
}
