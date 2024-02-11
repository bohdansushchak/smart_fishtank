import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/dependency_injection.dart';
import 'package:smart_fishtank/core/app_router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDI();
  runApp(MyApp(GetIt.I()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, {super.key});

  final AppRouter appRouter;

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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter.router,
      ),
    );
  }
}
