import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/auth/login/login_page.dart';
import 'package:smart_fishtank/home/home_page.dart';
import 'package:smart_fishtank/my_fish_tanks/my_fish_tanks_page.dart';

import '../auth/splash_page.dart';

class AppRouter {
  final AuthCubit _authCubit;

  AppRouter(this._authCubit);

  late final GoRouter router = GoRouter(
    refreshListenable: _authCubit,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoute.myFishTanks.path,
        name: AppRoute.myFishTanks.name,
        builder: (_, __) => const MyFishTanksPage(),
      )
    ],
    redirect: (context, state) {
      if (_authCubit.state.isAuthChecking) {
        return state.namedLocation(AppRoute.splash.name);
      } else if (!_authCubit.state.isLoggedIn) {
        return state.namedLocation(AppRoute.login.name);
      }
      return null;
    },
  );
}

enum AppRoute {
  home('/'),
  splash('/splash'),
  login('/login'),
  myFishTanks('/my-fish-tanks');

  const AppRoute(this.path);

  final String path;
}
