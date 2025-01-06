import 'package:flutter/material.dart';
import 'package:lab2_213094/screens/random_joke.dart';
import 'package:lab2_213094/screens/favorites.dart';
import 'package:lab2_213094/services/api_services.dart';

import '../widgets/joke_type_grid.dart';
import '../models/joke.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];
  List<Joke> favoriteJokes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    ApiService.getJokeTypes().then((response) {
      setState(() {
        jokeTypes = response;
      });
    });
  }

  void toggleFavorite(Joke joke) {
    setState(() {
      if (favoriteJokes.contains(joke)) {
        joke.isFavorite = false;
        favoriteJokes.remove(joke);
        print('Removed from favorites: ${joke.setup}');
      } else {
        joke.isFavorite = true;
        favoriteJokes.add(joke);
        print('Added to favorites: ${joke.setup}');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '213094',
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.underline,
          ),
        ),
        actions: [
          IconButton(
            icon: const Text(
              "RANDOM",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () async {
              final randomJoke = await ApiService.getRandomJoke();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomJoke(joke: randomJoke),
                ),
              );
            },
          ),
          IconButton(
            icon: const Text(
              "FAVORITES",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : JokeTypeGrid(
        jokeTypes: jokeTypes,
      ),
    );
  }
}
