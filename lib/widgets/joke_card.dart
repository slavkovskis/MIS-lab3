import 'package:flutter/material.dart';
import 'package:lab2_213094/provider/favorite_joke_provider.dart';
import '../models/joke.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteJokeProvider.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                joke.setup,
                style: const TextStyle(fontSize: 18),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 10),
              Text(
                joke.punchline,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              IconButton(
                icon: Icon(
                  provider.isExist(joke)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: provider.isExist(joke) ? Colors.red : Colors.grey,
                onPressed: () {
                  provider.toggleFavorite(joke);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
