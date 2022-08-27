// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, invalid_required_positional_param

import 'package:flutter/material.dart';

class PomodoroIcons extends StatelessWidget {
  final int completed;
  final int sets;

  PomodoroIcons({Key? key, required this.sets, required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iSize = 35.0;

    final completedSets = Icon(
      // Icons.beenhere,
      Icons.assignment_turned_in,
      // Icons.battery_full,
      color: Colors.orange[200],
      size: iSize,
    );

    final notCompletedSets = Icon(
      // Icons.beenhere_outlined,
      Icons.assignment_turned_in_outlined,
      // Icons.battery_0_bar,
      color: Colors.orange[200],
      size: iSize,
    );

    List<Icon> icons = [];

    for (int i = 0; i < sets; i++) {
      if (i < completed) {
        icons.add(completedSets);
      } else {
        icons.add(notCompletedSets);
      }
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: icons),
    );
  }
}
