// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroMain extends StatefulWidget {
  const PomodoroMain({Key? key}) : super(key: key);

  @override
  State<PomodoroMain> createState() => _PomodoroMainState();
}

class _PomodoroMainState extends State<PomodoroMain> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;

  Timer? timer;

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  void startTimer({bool reset = true}) {
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [timerProgress(), SizedBox(height: 100.0), buttons()],
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    final isOn = timer == null ? false : timer!.isActive;
    final isDone = seconds != 0 && seconds < maxSeconds;

    return isOn || isDone
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  if (isOn) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
                child: Text(
                  isOn ? "Pause" : "Resume",
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              width: 30.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  stopTimer();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ))
          ])
        : ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () {
              startTimer();
            },
            child: Text(
              'Start 50/10 Pomodoro timer',
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  Widget timerProgress() => SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 12,
              backgroundColor: Colors.blueGrey[400],
            ),
            Center(child: pomodoroTimer()),
          ],
        ),
      );

  Widget pomodoroTimer() {
    if (seconds == 0) {
      return Text("Completed!");
    } else {
      return Text(
        "$seconds",
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 60,
            color: Colors.brown[300]),
      );
    }
  }
}
