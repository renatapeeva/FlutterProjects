import 'package:flutter/material.dart';

class JokeList extends StatelessWidget {
  final Map<String, dynamic> joke;

  const JokeList({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white38, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            joke['setup'],
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            joke['punchline'],
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
