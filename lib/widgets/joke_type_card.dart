import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeTypeCard({super.key, required this.jokeType, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            Center(
              heightFactor: 3.5,
              child: Text(jokeType, style: const TextStyle(fontSize: 20),),)
          ],
        ),
      ),
    );
  }
}
