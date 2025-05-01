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
