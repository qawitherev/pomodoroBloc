import 'package:flutter/material.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:pomodoro/views/pomodoro_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PomodoroProvider(),
      child: const MaterialApp(
        title: 'Pomodoro App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
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
                "This is Pomodoro App", style: TextStyle(fontSize: 24),),
              const SizedBox(height: 15,),
              ElevatedButton(onPressed: () =>
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PomodoroPage())),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Center(
                    child: Text(
                        "Pomodoro App"
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


