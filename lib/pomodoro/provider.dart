import 'package:flutter/material.dart';

class PomodoroProvider extends ChangeNotifier {
  int duration = 25;
  int shortBreak = 5;
  int iteration = 4;
  int totalDuration = 0;

  void updatePomodoroSettings(int duration, int shortBreak, int iteration) {
    this.duration = duration;
    this.shortBreak = shortBreak;
    this.iteration = iteration;
  }

  void showTotalDuration() {
    totalDuration = duration*iteration;
    print("totalDuration: $totalDuration");
    notifyListeners();
  }
}
