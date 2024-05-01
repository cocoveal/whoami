import 'package:flutter/material.dart';
import 'package:whoami/styled_widgets.dart';
// import 'package:whoami/settings/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  // int time;

  // Settings({required this.time});

  // factory Settings.fromJson(Map<String, dynamic> json) {
  //   final time = json['time'] as int;
  //   return Settings(time: time);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'time': time,
  //   };
  // }

  Future<void> setPrefs(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<int> getPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(key)) {
      return prefs.getInt(key) ?? 0;
    } else {
      throw 'Setting not found';
    }
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // List<Settings> settings = [];

  // void getTime() {
  //   SettingsParser().loadSettings().then((value) => {
  //         if (value['time'] != null) {settings.add(Settings.fromJson(value))}
  //       });
  // }

  // void setTime(int time) {
  //   SettingsParser().saveSettings({'time': time});
  // }

  Settings settings = Settings();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey[900],
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: const SettingsText(
                text: 'Timer Duration',
                fontSize: 20,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: StyledTextButton(
                            onPressed: () {
                              settings.setPrefs('time', 30 * (i + 1));
                            },
                            text: '${30 * (i + 1)}s'),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
