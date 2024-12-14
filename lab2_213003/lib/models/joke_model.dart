class Joke {
  final String jokeType;
  final String setup;
  final String punchline;

  Joke({required this.jokeType, required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      jokeType: json['type'] ?? 'Unknown Type',
      setup: json['setup'] ?? 'No setup available',
      punchline: json['punchline'] ?? 'No punchline available',
    );
  }
}
