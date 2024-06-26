import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/core/app_router.dart';
import 'package:smart_fishtank/dependency_injection.dart';
import 'package:smart_fishtank/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/feature/theme/app_theme.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ValidationBuilder.setLocale('pl');
  initDI();
  runApp(MyApp(GetIt.I(), GetIt.I()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, this.theme, {super.key});

  final AppRouter appRouter;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<AuthCubit>(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: 'Smart Fish tank',
        theme: theme.light,
        darkTheme: theme.dark,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: appRouter.router,
        builder: (_, child) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: child,
        ),
      ),
    );
  }
}
