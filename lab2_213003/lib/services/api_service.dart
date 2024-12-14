import 'package:lab2_213003/models/joke_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<dynamic>> fetchJokeTypes() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<dynamic>> fetchJokesByType(String type) async {
    final response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  Future<Joke> fetchRandomJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['setup'] == null || data['punchline'] == null) {
        throw Exception('Invalid joke data: $data');
      }
      return Joke.fromJson(data);
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
