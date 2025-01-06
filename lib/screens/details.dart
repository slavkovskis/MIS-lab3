import 'package:flutter/material.dart';
import 'package:lab2_213094/services/api_services.dart';

import '../models/joke.dart';
import '../widgets/joke_grid.dart';

class JokeDetails extends StatefulWidget {
  const JokeDetails({super.key});

  @override
  State<JokeDetails> createState() => _JokeDetailsState();
}

class _JokeDetailsState extends State<JokeDetails> {
  List<Joke> jokes = [];
  String jokeType = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null || arguments is! String) {
      Navigator.pop(context);
      return;
    }
    jokeType = arguments;
    _getJokesForType(jokeType);
  }

  Future<void> _getJokesForType(String type) async {
    try {
      final response = await ApiService.getJokesByType(type);
      setState(() {
        jokes = response;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load jokes. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Center(
          widthFactor: 2,
          child: Text(
            jokeType,
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.red)))
          : jokes.isEmpty
          ? const Center(child: Text('No jokes available.'))
          : JokeGrid(jokes: jokes),
    );
  }
}
