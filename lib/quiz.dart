import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:whoami/results.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.selected,
    required this.timerDuration,
  });

  final Map<String, dynamic> selected;

  final int timerDuration;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  GyroscopeEvent? _gyroscopeEvent;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Duration sensorInterval = SensorInterval.normalInterval;

  List<String> selectedWords = [];

  Timer? timer;

  int? timeDuration;

  List<bool> correct = [];

  List<String> playedWords = [];

  bool isCorrect = false;

  bool isWrong = false;

  Timer? stateTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    timeDuration = widget.timerDuration;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeDuration! > 0) {
          timeDuration = timeDuration! - 1;
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsScreen(
                  selected: playedWords,
                  correct: correct,
                ),
              ));
        }
      });
    });

    final selected = widget.selected;
    selected.forEach((key, value) {
      if (value != null) {
        for (var i = 0; i < value.length; i++) {
          selectedWords.add(value[i]);
        }
      }
    });
    selectedWords.shuffle();

    _streamSubscriptions
        .add(gyroscopeEventStream(samplingPeriod: sensorInterval).listen(
      (GyroscopeEvent event) {
        setState(() {
          _gyroscopeEvent = event;

          if (stateTimer?.isActive == false || stateTimer == null) {
            if (_gyroscopeEvent!.y >= 6.0) {
              if (selectedWords.isNotEmpty && selectedWords.length > 1) {
                isWrong = true;
                playedWords.add(selectedWords.last);
                selectedWords.removeLast();
                correct.add(false);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsScreen(
                      selected: playedWords,
                      correct: correct,
                    ),
                  ),
                );
              }
            } else if (_gyroscopeEvent!.y <= -6.0) {
              if (selectedWords.isNotEmpty && selectedWords.length > 1) {
                isCorrect = true;
                playedWords.add(selectedWords.last);
                selectedWords.removeLast();
                correct.add(true);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsScreen(
                      selected: playedWords,
                      correct: correct,
                    ),
                  ),
                );
              }
            }
          }
        });
      },
      onError: (e) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Sensor not found'),
              content: Text('This device does not have a gyroscope.'),
            );
          },
        );
      },
      cancelOnError: true,
    ));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    selectedWords.clear();
    timer?.cancel();
    stateTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext parentContext) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
            body: RotatedBox(
                quarterTurns: 1,
                child: Builder(builder: (BuildContext context) {
                  if (isCorrect) {
                    if (timeDuration! < 3) {
                      return PlayingScreen(
                          timeDuration: timeDuration,
                          parentContext: parentContext,
                          text: 'Richtig',
                          color: Colors.green);
                    } else {
                      if (stateTimer?.isActive == false || stateTimer == null) {
                        stateTimer =
                          Timer(const Duration(milliseconds: 1500), () {
                        setState(() {
                          isCorrect = false;
                        });
                      });
                      }                      
                      return PlayingScreen(
                          timeDuration: timeDuration,
                          parentContext: parentContext,
                          text: 'Richtig',
                          color: Colors.green);
                    }
                  } else if (isWrong) {
                    if (timeDuration! < 3) {
                      return PlayingScreen(
                          timeDuration: timeDuration,
                          parentContext: parentContext,
                          text: 'Übersprungen',
                          color: Colors.red);
                    } else {
                      if (stateTimer?.isActive == false || stateTimer == null) {
                        stateTimer =
                          Timer(const Duration(milliseconds: 1500), () {
                        setState(() {
                          isWrong = false;
                        });
                      });
                      }
                      return PlayingScreen(
                          parentContext: parentContext,
                          timeDuration: timeDuration,
                          text: 'Übersprungen',
                          color: Colors.red);
                    }
                  } else {
                    return PlayingScreen(
                        parentContext: parentContext,
                        timeDuration: timeDuration,
                        text: selectedWords.last,
                        color: Colors.white);
                  }
                }))));
  }
}

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({
    super.key,
    required this.timeDuration,
    required this.text,
    required this.color,
    required this.parentContext,
  });

  final int? timeDuration;
  final String text;
  final Color color;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (color == Colors.white)
                IconButton(
                  onPressed: () {
                    Navigator.pop(parentContext);
                  },
                  icon: const Icon(Icons.cancel_sharp, size: 30),
                ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 40),
                  child: Text(
                    '$timeDuration',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blueGrey[900],
                        ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 80),
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                ),]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
