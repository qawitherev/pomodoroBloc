import 'package:flutter/material.dart';
import 'package:pomodoro/providers/pomodoro_provider.dart';
import 'package:pomodoro/providers/theme_provider.dart';
import 'package:pomodoro/theme_stuff/default_theme.dart';
import 'package:pomodoro/views/pomodoro_init_page.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<PomodoroProvider>(
          create: (_) => PomodoroProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider())
    ], child: const MyApp(),)
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: defaultTheme,
      darkTheme: darkTheme,
      themeMode: provider.themeMode,
      title: 'Pomodoro App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
    // return ChangeNotifierProvider(
    //   create: (BuildContext context) => PomodoroProvider(),
    //   child: MaterialApp(
    //     theme: defaultTheme,
    //     darkTheme: darkTheme,
    //     themeMode: ,
    //     title: 'Pomodoro App',
    //     debugShowCheckedModeBanner: false,
    //     home: const HomeScreen(),
    //   ),
    // );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
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
              const SizedBox(height: 15,),
              ElevatedButton(onPressed: () => provider.toggleTheme(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Center(
                    child: Text(
                        !provider.isDark ? "Change to Dark" : "Change to Light",
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


