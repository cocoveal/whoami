import 'package:flutter/material.dart';
import 'package:whoami/home.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhoAmI?',
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey[900]!),
        primaryColor: Colors.blueGrey[900],

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          titleTextStyle: const Material().textStyle,
        ),
      ),
    );
  }
}