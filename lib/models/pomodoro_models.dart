class PomodoroModel {
  int workDuration;
  int shortBreakDuration;
  int iteration;

  PomodoroModel({this.workDuration = 0, this.shortBreakDuration = 0, this.iteration = 0});

  @override
  String toString() {
    return "{workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, iteration: $iteration";
  }
}