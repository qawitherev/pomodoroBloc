import 'package:flutter/material.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:pomodoro/providers/settings_provider.dart';
import 'package:pomodoro/theme_stuff/color_themes.dart';
import 'package:pomodoro/views/common_artefacts.dart';
import 'package:pomodoro/views/pomodoro_init_page.dart';
import 'package:pomodoro/views/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PomodoroProvider>(
          create: (_) => PomodoroProvider()),
      ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      theme: settingsProvider.lightTheme,
      darkTheme: settingsProvider.darkTheme,
      themeMode: settingsProvider.themeMode,
      title: 'Pomodoro App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "This is Pomodoro App",
                style: TextStyle(fontSize: 24),
              ),
              const Vertical15(),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PomodoroPage())),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Center(
                    child: Text("Pomodoro App"),
                  ),
                ),
              ),
              const Vertical15(),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage())),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Center(child: Text("Settings")),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
