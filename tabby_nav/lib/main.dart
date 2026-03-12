import 'package:flutter/material.dart';
import 'screen_one.dart';
import 'screen_two.dart';
import 'screen_three.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Navigation',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: ScreenOne(),
      routes: {
        '/screenOne': (context) => ScreenOne(),
        '/screenTwo': (context) => ScreenTwo(),
        '/screenThree': (context) => ScreenThree()
      },
    );
  }
}
