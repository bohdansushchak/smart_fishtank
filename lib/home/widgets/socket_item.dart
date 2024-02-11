import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_settings.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_state.dart';

class SocketItem extends StatelessWidget {
  const SocketItem({
    super.key,
    required this.state,
    required this.settings,
  });

  final SocketState? state;
  final SmartFishTankSocketSettings? settings;

  IconData getIconType() {
    if (settings == null) {
      return Icons.device_unknown;
    }

    switch (settings!.type) {
      case SocketType.light:
        return Icons.lightbulb;
      case SocketType.airPump:
        return Icons.air;
      case SocketType.uv:
        return Icons.lightbulb_circle;
      case SocketType.co2:
        return Icons.local_gas_station;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(getIconType()),
          if (state?.isOn == true)
            Text(
              'Włączone',
              style: TextStyle(color: Colors.green),
            )
          else
            Text('Wyłaczone'),
          if (settings == null)
            Text('Nie skonfigurowane')
          else
            Text(
                '${settings!.fromHourUtc}:${settings!.fromMinUtc} - ${settings!.toHourUtc}:${settings!.toMinUtc}')
        ],
      ),
    );
  }
}
