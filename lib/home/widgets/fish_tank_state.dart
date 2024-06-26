import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fishtank/home/cubit/home_cubit.dart';
import 'package:smart_fishtank/home/widgets/socket_item.dart';

import '../../core/repositories/smart_fish_tank/models/smart_fish_tank.dart';

class FishTankState extends StatelessWidget {
  const FishTankState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [],
      ),
    );
  }
}
