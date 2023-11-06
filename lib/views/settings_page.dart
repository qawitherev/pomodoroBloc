import 'package:flutter/material.dart';
import 'package:pomodoro/theme_stuff/colours.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding:const  EdgeInsets.all(8.0),
        child: Center(child: Column(
          children: [
            Container(
              width: width-10,
              height: 30,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: theme.colorScheme.secondaryContainer,
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
