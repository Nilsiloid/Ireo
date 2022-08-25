import 'package:flutter/material.dart';
import 'package:ireo/models/pomodoro_status.dart';

const pomodoroTotalTime = 10; // 25 * 60;
const shortBreak = 3; // 5 * 60;
const longBreak = 5; // 15 * 60;

const pomodoroTotal = 4;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro:
      "Pomodoro is running, let's focus and get this work done!",
  PomodoroStatus.pausedPomodoro: "Ready for the next set? Let's GO!",
  PomodoroStatus.runningShortBreak:
      "Another set down, time for a deserved break!",
  PomodoroStatus.runningLongBreak:
      "WOO! More sets done, let's take a larger break!",
  PomodoroStatus.pausedShortBreak: "Let's have a break?",
  PomodoroStatus.pausedLongBreak: "Perhaps a nice walk will calm us down?",
  PomodoroStatus.setFinished: "Let's go! You've done it!! SIUUUUUUUUUUUUUUU!",
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.green,
  PomodoroStatus.pausedPomodoro: Colors.red,
  PomodoroStatus.runningShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Colors.orange,
  PomodoroStatus.pausedShortBreak: Colors.blueGrey,
  PomodoroStatus.pausedLongBreak: Colors.blueGrey,
  PomodoroStatus.setFinished: Colors.yellow,
};
