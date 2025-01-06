import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService {
  static Future<List<String>> getJokeTypes() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception("Failed to load joke types!");
    }
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(
        Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Joke> jokes = [];
      for (dynamic joke in data) {
        jokes.add(Joke.fromJson(joke));
      }
      return jokes;
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      throw Exception("Failed to load jokes!");
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Joke joke = Joke.fromJson(data);
      return joke;
    } else {
      throw Exception("Failed to load random jokes!");
    }
  }
}
