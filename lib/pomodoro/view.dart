import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class PomodoroPage extends StatelessWidget {
  final workDurationController = TextEditingController();
  final shortBreakController = TextEditingController();
  final iterationController = TextEditingController();

  PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PomodoroProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<PomodoroProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration:
                          const InputDecoration(hintText: 'Work Duration'),
                      controller: workDurationController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: 'Shortbreak Duration'),
                      controller: shortBreakController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: 'Iteration Number'),
                      controller: iterationController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer<PomodoroProvider>(
                      builder: (context, provider, child) {
                        return Text(
                            "Your pomodoro session will last for ${provider.totalDuration} minutes");
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final workDuration =
                        int.tryParse(workDurationController.text) ?? 25;
                    final shortBreak =
                        int.tryParse(shortBreakController.text) ?? 5;
                    final iteration =
                        int.tryParse(iterationController.text) ?? 4;

                    provider.updatePomodoroSettings(
                        workDuration, shortBreak, iteration);
                    provider.showTotalDuration();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      "Start Pomodoro",
                      style: TextStyle(fontSize: 18),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
