import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro_models.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatelessWidget {
  final vertBox = const SizedBox(
    height: 15,
  );
  final workDurationController = TextEditingController();
  final shortBreakDurationController = TextEditingController();
  final iterationController = TextEditingController();

  PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<PomodoroProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: SizedBox(
            width: width - 40,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: workDurationController,
                        decoration: const InputDecoration(
                          hintText: "Work Duration",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox,
                      TextField(
                        controller: shortBreakDurationController,
                        decoration: const InputDecoration(
                          hintText: "Short Break Duration",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox,
                      TextField(
                        controller: iterationController,
                        decoration: const InputDecoration(
                          hintText: "Iteration",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox,
                      vertBox,
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        int workDuration =
                            int.tryParse(workDurationController.text) ?? 0;
                        // print(provider)
                        int breakDuration = int.tryParse(shortBreakDurationController.text) ?? 0;
                        int iteration = int.tryParse(iterationController.text) ?? 0;
                        final model = PomodoroModel(workDuration: workDuration, shortBreakDuration: breakDuration, iteration: iteration);
                        if (workDuration == 0 || breakDuration ==0 || iteration==0) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cannot be 0"), duration: Duration(seconds: 2),));
                          return;
                        }
                        provider.initPomodoro(model);
                      },
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            "Start Pomodoro Session",
                          ),
                        ),
                      ),
                    ),
                    vertBox,
                    ElevatedButton(
                      onPressed: () => provider.pauseTimer(),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            "Pause Timer",
                          ),
                        ),
                      ),
                    ),
                    vertBox,
                    ElevatedButton(
                      onPressed: () {
                        provider.stopTimer();
                      },
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            "Reset Timer",
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
