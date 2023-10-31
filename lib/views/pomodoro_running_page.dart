import 'package:flutter/material.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:provider/provider.dart';

import '../models/pomodoro_models.dart';

class PomodoroRunningPage extends StatelessWidget {
  final PomodoroModel model;

  const PomodoroRunningPage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    PomodoroState state = provider.state;
    String stateString;
    switch (state) {
      case PomodoroState.working:
        stateString = "Working for ${provider.model.workDuration}";
        break;
      case PomodoroState.shortBreak:
        stateString = "Take a break for ${provider.model.shortBreakDuration}";
        break;
      case PomodoroState.finished:
        stateString = "Pomodoro Finished";
        break;
      default:
        stateString = "Unimplemented";
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
        centerTitle: true,
      ),
      body: provider.state != PomodoroState.finished ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<PomodoroProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          provider.state == PomodoroState.working
                              ? "${provider.workTime}"
                              : "${provider.breakTime}",
                          style: const TextStyle(fontSize: 30),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      stateString,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10,),
                    Consumer<PomodoroProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          "Iteration: ${provider.model.iteration}",
                          style: const TextStyle(fontSize: 15),
                        );
                      },
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      "Pause",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ) :
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Pomodoro Finished", style: TextStyle(fontSize: 30),),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("Do Again"),
            ))
          ],
        ),
      ),
    );
  }
}
