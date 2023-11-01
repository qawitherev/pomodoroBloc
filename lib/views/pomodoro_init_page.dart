import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro_models.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:pomodoro/views/pomodoro_running_page.dart';
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
    // final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<PomodoroProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Choose Your Preferred Pomodoro Preset",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      vertBox,
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.modelList.length * 2 + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0 ||
                                  index == provider.modelList.length * 2) {
                                return const SizedBox(
                                  width: 10,
                                );
                              } else if (index.isOdd) {
                                final item = provider.modelList[index ~/ 2];
                                final idx = index ~/ 2;
                                return _pomodoroPreset(
                                    context, item, idx, provider);
                              } else {
                                return const SizedBox(
                                  width: 10,
                                );
                              }
                            }),
                      ),
                      vertBox,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(),
                      ),
                      vertBox,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or Choose Your Own Preset",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      vertBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
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
                          ],
                        ),
                      ),
                      vertBox,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.selectedModelIndex != -1 && (workDurationController.text.isNotEmpty || shortBreakDurationController.text.isNotEmpty || iterationController.text.isNotEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please choose either preset"),
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }

                    PomodoroModel model;
                    if (provider.selectedModelIndex == -1) {
                      int workDuration =
                          int.tryParse(workDurationController.text) ?? 0;
                      // print(provider)
                      int breakDuration =
                          int.tryParse(shortBreakDurationController.text) ?? 0;
                      int iteration = int.tryParse(iterationController.text) ?? 0;
                      if (workDuration == 0 ||
                          breakDuration == 0 ||
                          iteration == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Cannot be 0"),
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }
                      model = PomodoroModel(
                          workDuration: workDuration,
                          shortBreakDuration: breakDuration,
                          iteration: iteration);
                      provider.initPomodoro(model);
                    } else {
                      model = provider.modelList[provider.selectedModelIndex];
                      provider.initPomodoro(model);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PomodoroRunningPage(
                                  model: model,
                                )));
                  },
                  child: const Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        "Start Pomodoro Session",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _pomodoroPreset(BuildContext context, PomodoroModel item, int idx,
      PomodoroProvider provider) {
    final h1 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: provider.selectedModelIndex == idx ? Colors.white: Colors.black);
    return GestureDetector(
      onTap: () => provider.selectModel(idx),
      child: Consumer<PomodoroProvider>(
        builder: (context, provider, child) {
          return Container(
            width: 200,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: provider.selectedModelIndex != idx ? Colors.transparent : Colors.blue,
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Preset #${idx+1}", style: h1),
                const SizedBox(
                  height: 10,
                ),
                Text("Work Duration: ${item.workDuration} min", style: h1.copyWith(fontSize: 14),),
                Text("Break Duration: ${item.shortBreakDuration} min", style: h1.copyWith(fontSize: 14),),
                Text("Iteration: ${item.iteration}", style: h1.copyWith(fontSize: 14),),
              ],
            ),
          );
        },
      ),
    );
  }
}

//TODO: handle when already tap preset, but want to choose own preset
