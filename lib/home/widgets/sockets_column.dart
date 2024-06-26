import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fishtank/home/widgets/socket_item.dart';

import '../../core/repositories/smart_fish_tank/models/smart_fish_tank.dart';
import '../cubit/home_cubit.dart';

class SocketsColumn extends StatelessWidget {
  const SocketsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final fishTank =
        context.select<HomeCubit, SmartFishTank?>((c) => c.state.fishTankState);
    if (fishTank == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SocketItem(
            socketNum: 1,
            state: fishTank.state?.socket1,
            settings: fishTank.settings?.socket1,
          ),
          const SizedBox(height: 8),
          SocketItem(
            socketNum: 2,
            state: fishTank.state?.socket2,
            settings: fishTank.settings?.socket2,
          ),
          const SizedBox(height: 8),
          SocketItem(
            socketNum: 3,
            state: fishTank.state?.socket3,
            settings: fishTank.settings?.socket3,
          ),
          const SizedBox(height: 8),
          SocketItem(
            socketNum: 4,
            state: fishTank.state?.socket4,
            settings: fishTank.settings?.socket4,
          ),
        ],
      ),
    );
  }
}
