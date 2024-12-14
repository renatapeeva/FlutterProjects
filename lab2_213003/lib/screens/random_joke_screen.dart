import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_service.dart';
import '../widgets/random_joke_data.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _State();
}

class _State extends State<RandomJokeScreen> {
  late Future<Joke> joke;

  @override
  void initState() {
    super.initState();
    joke = ApiService().fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Random Joke of the Day',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: FutureBuilder<Joke>(
                future: joke,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final joke = snapshot.data!;
                    return RandomJokeData(
                        setup: joke.setup, punchline: joke.punchline);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
