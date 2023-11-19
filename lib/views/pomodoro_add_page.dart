import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro_models.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:provider/provider.dart';

class PomodoroAddPage extends StatelessWidget {
  final nameController = TextEditingController();
  final workDurationController = TextEditingController();
  final breakDurationController = TextEditingController();
  final iterationController = TextEditingController();
  static const vertBox = SizedBox(height: 15,);

  PomodoroAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pomodoroProvider = Provider.of<PomodoroProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Pomodoro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter Your Pomodoro Preset", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      vertBox,
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      vertBox,
                      TextField(
                        controller: workDurationController,
                        decoration: const InputDecoration(
                          hintText: "Work Duration",
                          border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox,
                      TextField(
                        controller: breakDurationController,
                        decoration: const InputDecoration(
                            hintText: "Short Break duration",
                            border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox,
                      TextField(
                        controller: iterationController,
                        decoration: const InputDecoration(
                            hintText: "Iteration",
                            border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      vertBox
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text;
                    final workDuration = int.tryParse(workDurationController.text) ?? 0;
                    final breakDuration = int.tryParse(breakDurationController.text) ?? 0;
                    final iteration = int.tryParse(iterationController.text) ?? 0;
                    if (workDuration == 0 || breakDuration == 0 || iteration == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cannot be 0"), duration: Duration(seconds: 2),));
                      return;
                    }
                    if (name.isEmpty || workDurationController.text.isEmpty || breakDurationController.text.isEmpty || iterationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cannot be empty"), duration: Duration(seconds: 2),));
                      return;
                    }
                    final model = PomodoroModel(
                      name: name,
                      workDuration: workDuration,
                      shortBreakDuration: breakDuration,
                      iteration: iteration,
                    );
                    final res = await pomodoroProvider.addPomodoroPreset(model);
                    if (res) {
                      final savedModel = await pomodoroProvider.getSavedPomodoroPreset();
                      Navigator.pop(context);
                      print(savedModel);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already saved one"), duration: Duration(seconds: 2),));
                      final savedModel = await pomodoroProvider.getSavedPomodoroPreset();
                      print(savedModel);
                    }
                  },
                  child: const Center(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        "Save Preset",
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
}
