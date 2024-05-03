import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whoami/quiz.dart';
import 'package:whoami/settings/settings.dart';
import 'package:whoami/categories/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final Map<String, dynamic> selected = {};

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final scaffoldKey = widget.scaffoldKey;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: ScaffoldMessenger(
          key: scaffoldKey,
          child: Scaffold(
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
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
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
                    FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (context, snapshot) {
                          return TextButton(
                              onPressed: () {
                                const snack = SnackBar(
                                  content: Text('Choose a Category!',
                                      textAlign: TextAlign.center),
                                  duration: Duration(seconds: 1),
                                );
                                if (selected.isEmpty) {
                                  scaffoldKey.currentState?.showSnackBar(snack);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizScreen(
                                              selected: selected,
                                              timerDuration: snapshot.data
                                                      ?.getInt('time') ??
                                                  60,
                                            )),
                                  );
                                }
                              },
                              child: const Text('Start Quiz'));
                        }),
                    FutureBuilder(
                      future: Category().getCategories(),
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
  Map<String, dynamic> categories = {};
  List images = [];
  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot != null) {
      categories = widget.snapshot!;
    }

    for (int i = 0; i < categories.length; i++) {
      images.add(Image.asset(
        'assets/images/${categories.keys.elementAt(i)}.png',
        height: 100,
      ));
      isSelected.add(false);
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
                      icon: images.elementAt(i),
                      visualDensity: VisualDensity.comfortable,
                      constraints: BoxConstraints.tight(const Size(150, 150)),
                      isSelected: isSelected[i],
                      selectedIcon:
                          const Icon(Icons.check_circle_rounded, size: 100),
                      onPressed: () {
                        setState(() {
                          if (selected
                              .containsKey(categories.keys.elementAt(i))) {
                            selected.remove(categories.keys.elementAt(i));
                          } else {
                            selected.putIfAbsent(categories.keys.elementAt(i),
                                () => categories.values.elementAt(i));
                          }
                          isSelected[i] = !isSelected[i];
                        });
                      }),
                  Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        Text(categories.keys.elementAt(i),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ]),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
