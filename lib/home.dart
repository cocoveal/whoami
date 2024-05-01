import 'package:flutter/material.dart';
import 'package:whoami/settings/settings.dart';
import 'package:whoami/styled_widgets.dart';
import 'package:whoami/categories/category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                        builder: (context) => const SettingsScreen()),
                  );
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    children: [
                      for (int i = 0; i < 1; i++)
                        IconButton(
                          icon: const Icon(Icons.photo),
                          visualDensity: VisualDensity.compact,
                          iconSize: MediaQuery.of(context).size.width / 4,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoryScreen()),
                  );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
