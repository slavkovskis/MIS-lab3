import 'package:flutter/material.dart';
import 'package:lab2_213094/screens/details.dart';
import 'package:lab2_213094/widgets/joke_type_card.dart';

class JokeTypeGrid extends StatelessWidget {
  final List<String> jokeTypes;

  const JokeTypeGrid({super.key, required this.jokeTypes});

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
      itemCount: jokeTypes.length,
      itemBuilder: (context, index) {
        final jokeType = jokeTypes[index];
        return JokeTypeCard(
          jokeType: jokeType,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JokeDetails(),
                settings: RouteSettings(arguments: jokeType),
              ),
            );
          },
        );
      },
    );
  }
}
