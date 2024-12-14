import 'package:flutter/material.dart';
import 'package:lab2_213003/screens/home_screen.dart';
import 'package:lab2_213003/screens/joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/jokes": (context) => const JokeListScreen(jokeType: ''),
      },
    );
  }
}
