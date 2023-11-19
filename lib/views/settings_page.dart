import 'package:flutter/material.dart';
import 'package:pomodoro/theme_stuff/color_themes.dart';
import 'package:pomodoro/views/common_artefacts.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mode",
                style: TextStyle(fontSize: 20),
              ),
              const Vertical15(),
              CommonContainer10(
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
              const Vertical20(),
              const Text(
                "Theme Color",
                style: TextStyle(fontSize: 20),
              ),
              const Vertical15(),
              CommonContainer10(child: Center(
                child: SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.defaultTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? defaultTheme.colorScheme.primary
                                  : defaultDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Horizontal10(),
                        GestureDetector(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.redTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? redTheme.colorScheme.primary
                                  : redDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Horizontal10(),
                        GestureDetector(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.greenTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? greenTheme.colorScheme.primary
                                  : greenDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Horizontal10(),
                        GestureDetector(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.blueTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? blueTheme.colorScheme.primary
                                  : blueDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Horizontal10(),
                        GestureDetector(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.orangeTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? orangeTheme.colorScheme.primary
                                  : orangeDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Horizontal10(),
                        GestureDetector(
                          onTap: () => settingsProvider
                              .setThemeColor(ColorTheme.aquaTheme),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: !settingsProvider.isDark
                                  ? aquaTheme.colorScheme.primary
                                  : aquaDarkTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
              const Vertical20(),
              const Text(
                "Language",
                style: TextStyle(fontSize: 20),
              ),
              const Vertical15(),
              CommonContainer10(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: (width - 10) / 2,
                        child: const Text(
                          "Preferred Language",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        )),
                    ElevatedButton(
                        onPressed: () => _showDialog(context),
                         child: const Text("English")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {

  }
}
/*
settings
1. theme mode
2. language
3. color? -> disputable
4. about
 */
