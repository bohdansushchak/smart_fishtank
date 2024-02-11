import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_settings.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_state.dart';

import 'models/smart_fish_tank.dart';

class SmartFishTankRepository {
  final FirebaseAuth _fbAuth;
  final FirebaseDatabase _fbDatabase;

  SmartFishTankRepository(this._fbAuth, this._fbDatabase);

  Future<void> updateFishTankSettings(
      String fishTankUid, SmartFishTankSettings settings) async {
    await _fbDatabase
        .ref('/fishTanks/$fishTankUid/settings')
        .update(settings.toJson());
  }

  Future<void> updateFishTankState(
      String fishTankUid, SmartFishTankState state) async {
    await _fbDatabase
        .ref('/fishTanks/$fishTankUid/state')
        .update(state.toJson());
  }

  Future<SmartFishTank?> getFishTankState(String id) async {
    final res = await _fbDatabase.ref('fishTanks/$id').get();

    if (!res.exists || res.value == null) {
      return null;
    }

    final value = jsonDecode(jsonEncode(res.value));
    return SmartFishTank.fromJson(value);
  }

  Stream<SmartFishTank?> onChangeFishTankState(String id) {
    return _fbDatabase.ref('fishTanks/$id').onChildChanged.map((event) {
      if (!event.snapshot.exists || event.snapshot.value == null) {
        return null;
      }

      // final value = Map<String, dynamic>.from(
      //     event.snapshot.value as Map<Object?, Object?>);
      final value = jsonDecode(jsonEncode(event.snapshot.value));
      return SmartFishTank.fromJson(value);
    });
  }
}
