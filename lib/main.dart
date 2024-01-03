import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pomodoro Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int minute = 1500; // 25분
  bool isPaused = false;
  int counter = 0;
  late Timer _timer;

  void playTimerStart() {
    isPaused = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        minute--;
        if (minute == 0) {
          counter++;
          minute = 1500; 
        }
      });
    });
  }

  void playTimerStop() {
    setState(() {
      isPaused = false;
    });

    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      isPaused = false;
      minute = 1500;
    });
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Duration(seconds: minute).toString().substring(2, 7),
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isPaused
                        ? ElevatedButton(
                            onPressed: playTimerStop,
                            child: const Icon(Icons.pause))
                        : ElevatedButton(
                            onPressed: playTimerStart,
                            child: const Icon(Icons.play_arrow),
                          ),
                    const Gap(10),
                    ElevatedButton(
                        onPressed: _resetTimer,
                        child: const Icon(Icons.restore_rounded)),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.deepPurple,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pomodoros',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$counter',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
