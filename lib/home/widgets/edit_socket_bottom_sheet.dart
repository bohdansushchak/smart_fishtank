import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fishtank/core/repositories/smart_fish_tank/models/smart_fish_tank_settings.dart';
import 'package:smart_fishtank/core/utils/duration_extension.dart';
import 'package:smart_fishtank/core/utils/time_of_day_extension.dart';
import 'package:smart_fishtank/home/cubit/home_cubit.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../generated/l10n.dart';
import '../../widgets/select_button.dart';

const _defTimeFrom = TimeOfDay(hour: 8, minute: 0);
const _defTimeTo = TimeOfDay(hour: 16, minute: 0);

class EditSocketBottomSheet extends StatefulWidget {
  const EditSocketBottomSheet({
    super.key,
    required this.socketNum,
    this.socketConfig,
  });

  final SmartFishTankSocketSettings? socketConfig;
  final int socketNum;

  static void show(
    BuildContext context,
    int socketNum,
    SmartFishTankSocketSettings? socketConfig,
  ) {
    showModalBottomSheet(
      context: context,
      // constraints: const BoxConstraints(minHeight: 600, maxHeight: 700),
      // isScrollControlled: true,
      builder: (_) => EditSocketBottomSheet(
        socketNum: socketNum,
        socketConfig: socketConfig,
      ),
    );
  }

  @override
  State<EditSocketBottomSheet> createState() => _EditSocketBottomSheetState();
}

List<ClockLabel> _getTimes(Duration interval) {
  var curr = Duration.zero;
  final times = <ClockLabel>[];
  final count = 1440 ~/ interval.inMinutes;

  for (int i = 0; i < count; i++) {
    final time =
        TimeOfDay(hour: curr.inHours, minute: curr.inMinutes.remainder(60));

    final clock = ClockLabel.fromIndex(
      idx: i,
      length: count,
      text: time.hour.toString(),
    );
    times.add(clock);
    curr = curr + interval;
  }

  return times;
}

class _EditSocketBottomSheetState extends State<EditSocketBottomSheet> {
  late TimeOfDay timeFrom = widget.socketConfig?.timeFromLocal ?? _defTimeFrom;
  late TimeOfDay timeTo = widget.socketConfig?.timeToLocal ?? _defTimeTo;
  late SocketType? type = widget.socketConfig?.type;

  List<ClockLabel> labels = _getTimes(const Duration(minutes: 60));

  void onSubmit() {
    if (type == null) {
      return;
    }
    context.read<HomeCubit>().updateSocketConfig(
          widget.socketNum,
          timeFrom: timeFrom,
          timeTo: timeTo,
          type: type!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Socket ${widget.socketNum}"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Text('Type'),
                ...SocketType.values
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SelectBtn(
                          selected: e == type,
                          onPressed: () => setState(() {
                            type = e;
                          }),
                          child: Text(S.of(context).socketTypeSelect(e)),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: TimeRangePicker(
                hideTimes: true,
                hideButtons: true,
                use24HourFormat: false,
                start: timeFrom,
                end: timeTo,
                interval: const Duration(minutes: 10),
                minDuration: const Duration(minutes: 10),
                padding: 60,
                strokeWidth: 20,
                handlerRadius: 14,
                strokeColor: Colors.orange,
                handlerColor: Colors.orange[700],
                selectedColor: Colors.amber,
                backgroundColor: Colors.black.withOpacity(0.3),
                ticks: 12,
                ticksColor: Colors.white,
                snap: true,
                labels: labels,
                backgroundWidget: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      S.of(context).timeFromTo(timeFrom.hhmm(), timeTo.hhmm()),
                      // "${timeFrom.hhmm()} - ${timeTo.hhmm()} = ${timeFrom.difference(timeTo).format()}",
                    ),
                    Text(timeFrom.difference(timeTo).format()),
                  ],
                ),
                onStartChange: (time) => setState(() {
                  timeFrom = time;
                }),
                onEndChange: (time) => setState(() {
                  timeTo = time;
                }),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(S.of(context).disable),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(S.of(context).save),
              ),
            ],
          )
        ],
      ),
    );
  }
}
