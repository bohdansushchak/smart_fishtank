import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fishtank/core/repositories/user/models/profile.dart';
import 'package:smart_fishtank/home/widgets/add_fish_tank_form.dart';
import 'package:smart_fishtank/home/widgets/home_drawer.dart';

import '../core/repositories/user/models/my_fish_tank.dart';
import 'cubit/home_cubit.dart';
import 'widgets/fish_tank_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeCubit>(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: HomePageContent(),
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
      children: [
        BlocSelector<HomeCubit, HomeState, MyFishTank?>(
          selector: (state) => state.currentFishTank,
          builder: (_, fishTank) {
            return Text(fishTank?.name ?? fishTank?.uid ?? 'none');
          },
        ),
        FishTankState(),
        ElevatedButton(
          onPressed: () {
            context.read<HomeCubit>().setFishTankSettings();
          },
          child: Text('Set settings'),
        ),
        if (tanks == null || tanks.isEmpty) const AddFishTankForm(),
      ],
    );
  }
}
