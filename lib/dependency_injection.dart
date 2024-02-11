import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/auth/login/cubit/login_cubit.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/smart_fish_tank_repository.dart';
import 'package:smart_fishtank/home/cubit/home_cubit.dart';

import 'core/repositories/user/user_repository.dart';
import 'my_fish_tanks/cubit/my_fish_tanks_cubit.dart';
import 'core/app_router.dart';

final di = GetIt.I;

void initDI() {
  di.registerLazySingleton(() => AuthCubit(di(), di()));
  di.registerFactory(() => LoginCubit());
  di.registerFactory(() => MyFishTanksCubit(di(),));
  di.registerFactory(() => HomeCubit(di(), di(), di()));

  di.registerLazySingleton(() => AppRouter(di()));

  di.registerSingleton(FirebaseDatabase.instance);
  di.registerSingleton(FirebaseAuth.instance);

  di.registerFactory(() => SmartFishTankRepository(di(), di()));
  di.registerFactory(() => UserRepository(di(), di()));
}
