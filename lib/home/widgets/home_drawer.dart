import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/core/app_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoute.myFishTanks.name);
              },
              child: Text('Moje akwaria'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              child: Text('Wyloguj'),
            )
          ],
        ),
      ),
    );
  }
}
