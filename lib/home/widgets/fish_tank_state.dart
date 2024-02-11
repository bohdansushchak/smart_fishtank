import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fishtank/home/cubit/home_cubit.dart';
import 'package:smart_fishtank/home/widgets/socket_item.dart';

import '../../core/repositories/smart_fish_tank/models/smart_fish_tank.dart';

class FishTankState extends StatelessWidget {
  const FishTankState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.purple.withOpacity(0.1),
      ),
      child: Column(
        children: [
          BlocSelector<HomeCubit, HomeState, SmartFishTank?>(
            selector: (state) => state.fishTankState,
            builder: (_, fishTank) {
              if (fishTank == null) {
                return const SizedBox();
              }

              return Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  SocketItem(
                    state: fishTank.state?.socket1,
                    settings: fishTank.settings?.socket1,
                  ),
                  SocketItem(
                    state: fishTank.state?.socket2,
                    settings: fishTank.settings?.socket2,
                  ),
                  SocketItem(
                    state: fishTank.state?.socket3,
                    settings: fishTank.settings?.socket3,
                  ),
                  SocketItem(
                    state: fishTank.state?.socket4,
                    settings: fishTank.settings?.socket4,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
