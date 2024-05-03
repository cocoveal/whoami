import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  static const Duration _ignoreDuration = Duration(milliseconds: 20);
  GyroscopeEvent? _gyroscopeEvent;
  DateTime? _gyroscopeUpdateTime;
  int? _gyroscopeLastInterval;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Duration sensorInterval = SensorInterval.normalInterval;

  List<String> selectedWords = [];

  Timer? timer;

  int? timeDuration;

  int time = 0;

  Timer? switchTimer;

  void startTimer() {
    switchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time = time - 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    // ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    timeDuration = widget.timerDuration;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeDuration! > 0) {
          timeDuration = timeDuration! - 1;
        } else {
          Navigator.pop(context);
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
        final now = DateTime.now();
        setState(() {
          _gyroscopeEvent = event;
          if (_gyroscopeUpdateTime != null) {
            final interval = now.difference(_gyroscopeUpdateTime!);
            if (interval > _ignoreDuration) {
              _gyroscopeLastInterval = interval.inMilliseconds;
            }
          }
        });
        _gyroscopeUpdateTime = now;

        if (_gyroscopeEvent!.y > 4 && time == 0) {
          setState(() {
            if (selectedWords.isNotEmpty && selectedWords.length > 1) {
              selectedWords.removeLast();
            } else {
              Navigator.pop(context);
            }
            time = 3;
            startTimer();
          });
        }
        if (_gyroscopeEvent!.y < -4 && time == 0) {
          setState(() {
            if (selectedWords.isNotEmpty && selectedWords.length > 1) {
              selectedWords.removeLast();
            } else {
              Navigator.pop(context);
            }
            time = 3;
            startTimer();
          });
        }
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
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    selectedWords.clear();
    //widget.selected.clear();
    timer?.cancel();
    if(switchTimer != null) {
      switchTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
            body: RotatedBox(
                quarterTurns: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_sharp, size: 30),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 40),
                            child: Text(
                              '$timeDuration',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
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
                        child: Text(
                          selectedWords.last,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
