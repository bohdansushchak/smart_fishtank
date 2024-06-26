import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/home/widgets/add_fish_tank_form.dart';
import 'package:smart_fishtank/home/widgets/home_drawer.dart';
import 'package:smart_fishtank/home/widgets/sockets_column.dart';

import '../core/repositories/user/models/my_fish_tank.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String path = '/';
  static const String name = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeCubit>(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: const HomePageContent(),
        drawer: const HomeDrawer(),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final tanks = context
        .select<HomeCubit, List<MyFishTank>?>((c) => c.state.myFishTanks);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (tanks == null || tanks.isEmpty) const AddFishTankForm(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // FishTankState(),
            SocketsColumn(),
          ],
        ),
      ],
    );
  }
}
