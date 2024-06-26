import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/feature/auth/login/login_page.dart';
import 'package:smart_fishtank/home/home_page.dart';
import 'package:smart_fishtank/my_fish_tanks/my_fish_tanks_page.dart';

import '../feature/auth/splash_page.dart';

class AppRouter {
  final AuthCubit _authCubit;

  AppRouter(this._authCubit);

  late final GoRouter router = GoRouter(
    refreshListenable: _authCubit,
    routes: <RouteBase>[
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: SplashPage.path,
        name: SplashPage.name,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: LoginPage.path,
        name: LoginPage.name,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: MyFishTanksPage.path,
        name: MyFishTanksPage.name,
        builder: (_, __) => const MyFishTanksPage(),
      )
    ],
    redirect: (context, state) {
      if (_authCubit.state.isAuthChecking) {
        return state.namedLocation(SplashPage.name);
      } else if (!_authCubit.state.isLoggedIn) {
        return state.namedLocation(LoginPage.name);
      }
      return null;
    },
  );
}
