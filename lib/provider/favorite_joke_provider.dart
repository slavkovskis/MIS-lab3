import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/joke.dart';

class FavoriteJokeProvider with ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => _favoriteJokes;


  void toggleFavorite(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
      joke.isFavorite = false;
    } else {
      _favoriteJokes.add(joke);
      joke.isFavorite = true;
    }
    notifyListeners();
  }

  bool isExist(Joke joke) {
    final isExist = _favoriteJokes.contains(joke);
    return isExist;
  }

  static FavoriteJokeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteJokeProvider>(
      context,
      listen: listen,
    );
  }
}
