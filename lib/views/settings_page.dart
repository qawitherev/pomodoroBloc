import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mode",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: width - 10,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: theme.colorScheme.secondaryContainer,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Is Dark",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                      value: settingsProvider.isDark,
                      onChanged: (value) => settingsProvider.toggleTheme())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
settings
1. theme mode
2. language
3. color? -> disputable
4. about
 */
