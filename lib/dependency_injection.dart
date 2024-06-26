import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/smart_fish_tank_repository.dart';

import 'core/app_router.dart';
import 'core/repositories/auth/auth_repository.dart';
import 'core/repositories/user/user_repository.dart';
import 'feature/auth/cubit/auth_cubit.dart';
import 'feature/auth/login/cubit/login_cubit.dart';
import 'feature/theme/app_theme.dart';
import 'home/cubit/home_cubit.dart';
import 'my_fish_tanks/cubit/my_fish_tanks_cubit.dart';

final di = GetIt.I;

void initDI() {
  di.registerLazySingleton(() => AppRouter(di()));
  di.registerFactory(() => AppTheme());

  di.registerSingleton(FirebaseDatabase.instance);
  di.registerSingleton(FirebaseAuth.instance);

  _initRepositories();
  _initCubits();
}

void _initRepositories() {
  di.registerFactory(() => AuthRepository(di()));
  di.registerFactory(() => SmartFishTankRepository(di(), di()));
  di.registerFactory(() => UserRepository(di(), di()));
}

void _initCubits() {
  di.registerLazySingleton(() => AuthCubit(di(), di()));
  di.registerFactory(() => LoginCubit(di()));
  di.registerFactory(() => MyFishTanksCubit(di()));
  di.registerFactory(() => HomeCubit(di(), di(), di()));
}
