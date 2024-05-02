import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whoami/quiz.dart';
import 'package:whoami/settings/settings.dart';
import 'package:whoami/categories/category.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final Map<String, dynamic> selected = {};

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuizScreen(selected: selected)),
                        );
                      },
                      child: const Text('Start Quiz')),
                  FutureBuilder(
                    future: Category(name: 'test').getCategories(),
                    builder: (context, snapshot) {
                      return CategoryGrid(
                        snapshot: snapshot.data,
                        context: context,
                        selected: selected,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}

class CategoryGrid extends StatefulWidget {
  CategoryGrid({
    super.key,
    required this.snapshot,
    required this.context,
    required this.selected,
  });

  final Map<String, dynamic>? snapshot;
  final BuildContext context;

  final Map<String, dynamic> categories = {};
  final Map<String, dynamic> selected;

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> categories = {};
    if (widget.snapshot != null) {
      categories = widget.snapshot!;
    } else {
      return const CircularProgressIndicator();
    }
    final selected = widget.selected;

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          children: [
            for (int i = 0; i < categories.length; i++)
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  IconButton(
                    icon: Image.asset('assets/images/ironman.png', height: 100),
                    visualDensity: VisualDensity.comfortable,
                    iconSize: MediaQuery.of(context).size.width / 4,
                    onPressed: () {
                      setState(() {
                        selected.putIfAbsent(categories.keys.elementAt(i),
                            () => categories.values.elementAt(i));
                      });
                      //print(selected);
                    },
                  ),
                  Text(categories.keys.elementAt(i),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
