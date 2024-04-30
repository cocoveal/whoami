import 'package:flutter/material.dart';
import 'package:whoami/settings/settings.dart';
import 'package:whoami/styled_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey[900],
            centerTitle: true,
            title: const Text(
              'WhoAmI?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen()
                    ),
                  );
                },
              )
            ],
        ),

        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: StyledHomeButton(
                    onPressed: () {},
                    text: 'Who Am I?',
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
