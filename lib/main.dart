import 'package:flutter/material.dart';
import 'package:pomodoro/pomodoro/provider.dart';
import 'package:pomodoro/pomodoro/view.dart';
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
      body: Center(
        child: Column(
          children: [
            const Text("This is Pomodoro App", style: TextStyle(fontSize: 24),),
            const SizedBox(height: 15,),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PomodoroPage())), child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
    );
  }
}


