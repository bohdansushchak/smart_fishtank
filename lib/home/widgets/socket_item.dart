import 'package:flutter/material.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_settings.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_state.dart';
import 'package:smart_fishtank/core/utils/time_of_day_extension.dart';
import 'package:smart_fishtank/home/widgets/edit_socket_bottom_sheet.dart';

import '../../generated/l10n.dart';

class SocketItem extends StatelessWidget {
  const SocketItem({
    super.key,
    required this.socketNum,
    required this.state,
    required this.settings,
  });

  final int socketNum;
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
    final textTheme = Theme.of(context).textTheme;

    Widget child;
    final set = settings;
    if (set == null) {
      child = const Center(
        child: Text('Non set'),
      );
    } else {
      child = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  getIconType(),
                  color: Colors.blueAccent,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    S.of(context).socketTypeSelect(set.type),
                    style: textTheme.bodySmall,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state?.isOn == true || state?.force == true
                        ? Colors.green
                        : Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
          // Text('${set.timeFromUtc.hhmm()} - ${set.timeToUtc.hhmm()}'),
          Text('${set.timeFromLocal.hhmm()} - ${set.timeToLocal.hhmm()}'),
          Text(set.duration.inHours.toString()),
        ],
      );
    }

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey,
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onLongPress: () =>
            EditSocketBottomSheet.show(context, socketNum, settings),
        onTap: () {},
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: state?.force != null ? Border.all(color: Colors.red) : null,
          ),
          child: Stack(
            children: [
              Positioned.fill(child: child),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: Text(socketNum.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
