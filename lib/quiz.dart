import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whoami/settings/settings.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.selected,
  });

  final Map<String, dynamic> selected;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
          body: Column(
            children: [
              TextButton(
                onPressed: () {
                  selected.clear();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
                child: const Text('Exit'),
              ),
              Text(selected.toString()),
            ],
          ),
        ));
  }
}
