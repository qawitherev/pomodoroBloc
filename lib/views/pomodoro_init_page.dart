import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro/models/pomodoro_models.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:pomodoro/views/pomodoro_add_page.dart';
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
    final theme = Theme.of(context);
    final provider = Provider.of<PomodoroProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Choose Your Preferred Pomodoro Preset",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      vertBox,
                      SizedBox(
                        height: 150,
                        // child: ListView(
                        //   scrollDirection: Axis.horizontal,
                        //   children: _getPresetHorizontalList(context, provider, theme),
                        // ),
                        child: Consumer<PomodoroProvider>(
                          builder: (context, provider, child) {
                            return FutureBuilder<List<Widget>>(
                              future: _getPresetHorizontalList(
                                  context, provider, theme),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Widget>> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    children: snapshot.data!,
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          },
                        ),
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
                    if (provider.selectedModelIndex != -1 &&
                        (workDurationController.text.isNotEmpty ||
                            shortBreakDurationController.text.isNotEmpty ||
                            iterationController.text.isNotEmpty)) {
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
                      int iteration =
                          int.tryParse(iterationController.text) ?? 0;
                      if (workDuration == 0 ||
                          breakDuration == 0 ||
                          iteration == 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
      PomodoroProvider provider, ThemeData theme) {
    final h1 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _getContainerTextColor(provider, idx, theme, context),
      // color: Theme.of(context).colorScheme.onPrimaryContainer
    );
    return GestureDetector(
      onLongPress: () => _deleteSavedPreset(context, item, provider),
      onTap: () => provider.selectModel(idx),
      child: Consumer<PomodoroProvider>(
        builder: (context, provider, child) {
          return Container(
            width: 200,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: provider.selectedModelIndex != idx
                  ? Colors.transparent
                  : theme.colorScheme.primary,
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: h1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Work Duration: ${item.workDuration} min",
                  style: h1.copyWith(fontSize: 14),
                ),
                Text(
                  "Break Duration: ${item.shortBreakDuration} min",
                  style: h1.copyWith(fontSize: 14),
                ),
                Text(
                  "Iteration: ${item.iteration}",
                  style: h1.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getContainerTextColor(PomodoroProvider provider, int index,
      ThemeData theme, BuildContext context) {
    // final brightness = Theme.of(context).brightness;
    // if (brightness == Brightness.light) {
    //   if (provider.selectedModelIndex == index) {
    //     return Colors.white;
    //   } else {
    //     return Colors.black;
    //   }
    // } else if (brightness == Brightness.dark) {
    //   return Colors.white;
    // } else {
    //   throw UnimplementedError("No Color");
    // }
    if (provider.selectedModelIndex == index) {
      return Theme.of(context).colorScheme.onPrimary;
    } else {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }

  Future<List<Widget>> _getPresetHorizontalList(
      BuildContext context, PomodoroProvider provider, ThemeData theme) async {
    final theList = <Widget>[];
    List.generate(provider.modelList.length * 2, (index) {
      if (index == 0) {
        theList.add(const SizedBox(
          width: 10,
        ));
      } else if (index.isOdd) {
        final item = provider.modelList[index ~/ 2];
        final idx = index ~/ 2;
        theList.add(_pomodoroPreset(context, item, idx, provider, theme));
      } else if (index.isEven) {
        theList.add(const SizedBox(
          width: 8,
        ));
      } else {
        throw RangeError("Index doesn't exist");
      }
    });
    //TODO: add the add button here
    final addContainer = GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => PomodoroAddPage())),
      child: Container(
        width: 200,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/ic_add_preset.svg",
            color: theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
    theList.add(const SizedBox(
      width: 8,
    ));
    if (await provider.getSavedPomodoroPreset() == null) {
      theList.add(addContainer);
    }
    theList.add(const SizedBox(
      width: 10,
    ));
    return theList;
  }

  void _deleteSavedPreset(BuildContext context, PomodoroModel model,
      PomodoroProvider provider) async {
    if (model.name == "Preset #1" ||
        model.name == "Preset #2" ||
        model.name == "Preset #3") {
      return;
    }
    _showDialog(context, model, provider);
  }

  void _showDialog(
      BuildContext context, PomodoroModel model, PomodoroProvider provider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete ${model.name}?"),
            content: const Text("This action is irreversible"),
            actions: [
              FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    provider.deleteSavedPreset();
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }
}
