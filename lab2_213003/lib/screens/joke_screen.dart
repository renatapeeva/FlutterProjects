import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/joke_list.dart';
import 'package:intl/intl.dart';

class JokeListScreen extends StatefulWidget {
  final String jokeType;

  const JokeListScreen({Key? key, required this.jokeType}) : super(key: key);

  @override
  State<JokeListScreen> createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<dynamic>> _jokes;

  @override
  void initState() {
    super.initState();
    _jokes = ApiService.fetchJokesByType(widget.jokeType);
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
              title: Text(
                '${toBeginningOfSentenceCase(widget.jokeType)} Jokes',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _jokes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sentiment_dissatisfied,
                              color: Colors.grey, size: 40),
                          const SizedBox(height: 8),
                          const Text(
                            'No jokes found.',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final joke = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: JokeList(joke: joke),
                        );
                      },
                    );
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
