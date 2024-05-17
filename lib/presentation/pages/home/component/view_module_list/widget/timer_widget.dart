import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';

class TimerWidget extends StatefulWidget {
  final DateTime endTime;
  const TimerWidget({super.key, required this.endTime});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  late Duration remainTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    remainTime = widget.endTime.difference(DateTime.now());
    if (remainTime > Duration.zero) {
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          remainTime = widget.endTime.difference(DateTime.now());
          if (remainTime <= Duration.zero) {
            _timer?.cancel();
          }
          setState(() {});
        },
      );
    }
  }

  String _printDuration(Duration duration) {
    if (duration <= Duration.zero) {
      return 'TIME OUT';
    }
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String twoDigitMinutes = twoDigits(duration.inMinutes % 60);
    String twoDigitSeconds = twoDigits(duration.inSeconds % 60);
    String twoDigitHours = twoDigits(duration.inHours);

    return '$twoDigitHours:${twoDigitMinutes}:${twoDigitSeconds}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _printDuration(remainTime),
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.contentPrimary,
          )
          .semiBold,
    );
  }
}
