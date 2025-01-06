import 'dart:convert';

List<Joke> jokeFromJson(String str) => List<Joke>.from(json.decode(str).map((x) => Joke.fromJson(x)));

String jokeToJson(List<Joke> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Joke {
  final int id;
  final String type;
  final String setup;
  final String punchline;
  bool isFavorite;

  Joke({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
    this.isFavorite = false,
  });

  Joke copyWith({
    int? id,
    String? type,
    String? setup,
    String? punchline,
    bool? isFavorite,
  }) =>
      Joke(
        id: id ?? this.id,
        type: type ?? this.type,
        setup: setup ?? this.setup,
        punchline: punchline ?? this.punchline,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
    id: json["id"],
    type: json["type"],
    setup: json["setup"],
    punchline: json["punchline"],
    isFavorite: json["isFavorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "setup": setup,
    "punchline": punchline,
    "isFavorite": isFavorite,
  };
}
