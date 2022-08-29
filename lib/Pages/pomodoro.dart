// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_element

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Pomodoro/constants.dart';
import 'package:ireo/Pomodoro/pomodoro_icons.dart';
import 'package:ireo/Utilities/routes.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ireo/Pomodoro/custom_buttons.dart';
import 'package:ireo/models/pomodoro_status.dart';
import 'dart:async';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

const _start = "Start";
const _resume = "Resume Pomodoro";
const _pause = "Pause Pomodoro";
const _stop = "Stop";
const _reset = "Reset";
const _pauseBreak = "Pause Break";
const _resumeBreak = "Resume Break";
const _startBreak = 'Start Break';
const _nextset = "Start next set";

class _PomodoroState extends State<Pomodoro> {
  static AudioCache mediaplayer = AudioCache();

  int remainingTime = pomodoroTotalTime;
  String button = _start;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;

  Timer? _timer;
  int pomodoroNum = 0;
  int setNum = 0;

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    mediaplayer.load('timer.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Row(children: [
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, Routes.HomePath);
                },
                child: Text("Back", style: TextStyle(fontSize: 15)),
              ),
              SizedBox(
                width: 90,
              ),
            ]),
            Text(
              "Set: $setNum",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Text(
              "Pomodoro Num: $pomodoroNum",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 15.0,
                  percent: _percentageSetCompleted(),
                  circularStrokeCap: CircularStrokeCap.butt,
                  center: Text(
                    _secondstoFormattedString(remainingTime),
                    style: TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  progressColor: statusColor[pomodoroStatus],
                ),
                PomodoroIcons(sets: pomodorosEachSet, completed: pomodoroNum),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  statusDescription[pomodoroStatus]!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(onTap: _pomodoro, text: button),
                CustomButton(
                    onTap: ((pomodoroStatus == PomodoroStatus.pausedPomodoro) ||
                            (pomodoroStatus == PomodoroStatus.runningPomodoro))
                        ? _resetPomodoroCounter
                        : _resetBreakTimer,
                    text: 'Reset Timer'),
                CustomButton(onTap: _resetPomodoro, text: 'Reset Pomodoro'),
              ],
            ))
          ],
        ),
      )),
    );
  }

  _secondstoFormattedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - roundedMinutes * 60;
    String remainingSecondsFormatted;

    if (remainingSeconds < 10) {
      remainingSecondsFormatted = "0$remainingSeconds";
    } else {
      remainingSecondsFormatted = "$remainingSeconds";
    }
    return "$roundedMinutes:$remainingSecondsFormatted";
  }

  _percentageSetCompleted() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.runningShortBreak:
        totalTime = shortBreak;
        break;
      case PomodoroStatus.pausedShortBreak:
        totalTime = shortBreak;
        break;
      case PomodoroStatus.runningLongBreak:
        totalTime = longBreak;
        break;
      case PomodoroStatus.pausedLongBreak:
        totalTime = longBreak;
        break;
      case PomodoroStatus.setFinished:
        setNum++;
        pomodoroNum = 0;
        totalTime = pomodoroTotalTime;
        break;
    }

    double percentage = (totalTime - remainingTime) / totalTime;
    return percentage;
  }

  _pomodoro() {
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedPomodoro:
        _startPomodoroCounter();
        break;
      case PomodoroStatus.runningPomodoro:
        _pausePomodoroCounter();
        break;
      case PomodoroStatus.runningShortBreak:
        _pauseBreakTimer();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startBreakTimer();
        break;
      case PomodoroStatus.runningLongBreak:
        _pauseBreakTimer();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startBreakTimer();
        break;
      case PomodoroStatus.setFinished:
        setNum++;
        _startPomodoroCounter();
        break;
    }
  }

  _startPomodoroCounter() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;

    _stopTimer();
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                    button = _pause;
                  })
                }
              else
                {
                  _soundForStartAndEnd(),
                  pomodoroNum++,
                  _stopTimer(),
                  if (pomodoroNum % pomodorosEachSet == 0)
                    {
                      setState(() {
                        debugPrint("$pomodoroStatus");
                        setNum++;
                        remainingTime = longBreak;
                        pomodoroStatus = PomodoroStatus.pausedLongBreak;
                        button = _startBreak;
                      }),
                    }
                  else
                    {
                      setState(() {
                        remainingTime = shortBreak;
                        pomodoroStatus = PomodoroStatus.pausedShortBreak;
                        button = _startBreak;
                      }),
                    }
                }
            });
  }

  _pausePomodoroCounter() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;

    _stopTimer();

    setState(() {
      button = _resume;
    });
  }

  _resetPomodoroCounter() {
    _stopTimer();
    _stopPomodoroCounter();
  }

  _stopPomodoroCounter() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      button = _start;
      remainingTime = pomodoroTotalTime;
    });
  }

  _startBreakTimer() {
    pomodoroStatus = (pomodoroStatus == PomodoroStatus.pausedLongBreak)
        ? PomodoroStatus.runningLongBreak
        : PomodoroStatus.runningShortBreak;

    remainingTime = (pomodoroStatus == PomodoroStatus.runningLongBreak)
        ? longBreak
        : shortBreak;

    _stopTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          button = _pauseBreak;
        });
      } else {
        _soundForStartAndEnd();
        _stopTimer();
        if (pomodoroNum % pomodorosEachSet == 0) {
          pomodoroStatus = PomodoroStatus.setFinished;
        } else {
          pomodoroStatus = PomodoroStatus.pausedPomodoro;
        }
        setState(() {
          remainingTime = pomodoroTotalTime;
          button = (pomodoroStatus == PomodoroStatus.setFinished)
              ? _nextset
              : _start;
        });
      }
    });
  }

  _pauseBreakTimer() {
    pomodoroStatus = (pomodoroStatus == PomodoroStatus.runningShortBreak)
        ? PomodoroStatus.pausedShortBreak
        : PomodoroStatus.pausedLongBreak;

    _stopTimer();

    setState(() {
      button = _resumeBreak;
    });
  }

  _resetBreakTimer() {
    _stopTimer();
    _stopBreakTimer();
  }

  _stopBreakTimer() {
    pomodoroStatus = (pomodoroStatus == PomodoroStatus.runningShortBreak)
        ? PomodoroStatus.pausedShortBreak
        : PomodoroStatus.pausedLongBreak;
    setState(() {
      button = _startBreak;
      remainingTime = (pomodoroStatus == PomodoroStatus.pausedLongBreak)
          ? longBreak
          : shortBreak;
    });
  }

  _stopTimer() {
    // debugPrint("timer = $timer");
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  _resetPomodoro() {
    _stopTimer();
    setState(() {
      button = _start;
      pomodoroStatus = PomodoroStatus.pausedPomodoro;
      remainingTime = pomodoroTotalTime;
      setNum = 0;
      pomodoroNum = 0;
    });
  }

  _soundForStartAndEnd() {
    mediaplayer.play('timer.mp3');
  }
}
