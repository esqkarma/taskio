import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayDisplay extends StatelessWidget {
  const DayDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEEE').format(DateTime.now());

    return Text(
      today,
      style: const TextStyle(
          fontSize: 24,
          fontFamily: 'Cagody',
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
}

String formatTime(int totalSeconds) {
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  final hoursStr = hours.toString().padLeft(2, '0');
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = seconds.toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr:$secondsStr';
}
