import 'package:flutter/material.dart';
import 'package:whoami/styled_widgets.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            )
        ),
        
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
                    for(int i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: StyledTextButton(
                            onPressed: () {}, text: '${30 * (i + 1)}s'),
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
