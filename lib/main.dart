import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoami/home.dart';
import 'package:flutter/services.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((value) => runApp(const AppRoot()));
    // runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhoAmI?',
      home: HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey[900]!),
        primaryColor: Colors.blueGrey[900],
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900]),
            alignment: Alignment.center,
            padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          displayMedium: TextStyle(
            color: Colors.blueGrey[900],
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          titleTextStyle: const Material().textStyle,
        ),
      ),
    );
  }
}
