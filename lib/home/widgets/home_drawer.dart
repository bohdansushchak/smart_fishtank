import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/my_fish_tanks/my_fish_tanks_page.dart';

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
                context.pushNamed(MyFishTanksPage.name);
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
