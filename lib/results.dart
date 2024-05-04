import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.selected,
    required this.correct,
    });

  final List<String> selected;
  final List<bool> correct;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home_filled, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          title: const Text('Results', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                for (int i = 0; i < selected.length; i++)
                  Text( selected[i], style: TextStyle(
                    color: correct[i] ? Colors.green : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        )
      ),
    );
  }
}