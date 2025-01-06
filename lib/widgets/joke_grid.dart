import 'package:flutter/cupertino.dart';

import '../models/joke.dart';
import 'joke_card.dart';

class JokeGrid extends StatefulWidget {
  final List<Joke> jokes;

  const JokeGrid({super.key, required this.jokes});

  @override
  _JokeGridState createState() => _JokeGridState();
}

class _JokeGridState extends State<JokeGrid> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
        crossAxisSpacing: 7.5,
        mainAxisSpacing: 7.5,
      ),
      itemCount: widget.jokes.length,
      itemBuilder: (context, index) {
        final joke = widget.jokes[index];
        return JokeCard(
          joke: joke,
        );
      },
    );
  }
}
