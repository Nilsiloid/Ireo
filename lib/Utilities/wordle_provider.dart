// ignore_for_file: non_constant_identifier_names

import 'dart:math';

class Wordle {
  int rowID = 0;
  int letterID = 0;
  static String game_msg = "";
  static String game_guess = "";
  static List<String> words = [
    "WORLD",
    "FIGHT",
    "BRAIN",
    "PLANE",
    "EARTH",
    "ROBOT",
    "REACH",
    "PEACE",
    "BRAKE",
    "CRANK",
    "PRANK",
    "ROAST",
    "TOAST",
    "CAMEL",
    "HUNCH",
    "MUNCH",
    "RANCH",
    "FLAME",
    "CROAK",
    "CRUEL",
    "DEATH",
    "LEACH",
    "FETCH"
  ];
  static bool gameEnd = false;
  static List<Letter> wordleRow = List.generate(5, (index) => Letter("", 0));

  List<List<Letter>> board =
      List.generate(5, (index) => List.generate(5, (index) => Letter("", 0)));

  static void initGame() {
    final random = Random();
    int index = random.nextInt(words.length);
    game_guess = words[index];
  }

  void insertWord(index, word) {
    board[rowID][index] = word;
  }

  bool checkWordExist(String word) {
    return words.contains(word);
  }
}

class Letter {
  String? letter;
  int code = 0;
  Letter(this.letter, this.code);
}
