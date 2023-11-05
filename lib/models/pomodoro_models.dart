class PomodoroModel {
  String name;
  int workDuration;
  int shortBreakDuration;
  int iteration;

  PomodoroModel({this.name = "", this.workDuration = 0, this.shortBreakDuration = 0, this.iteration = 0});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "workDuration": workDuration,
      "shortBreakDuration": shortBreakDuration,
      "iteration": iteration
    };
  }

  static PomodoroModel fromMap(Map<String, dynamic> map) {
    return PomodoroModel(
      name: map["name"],
      workDuration: map["workDuration"],
      shortBreakDuration: map["shortBreakDuration"],
      iteration: map["iteration"]
    );
  }

  @override
  String toString() {
    return "{workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, iteration: $iteration}";
  }
}