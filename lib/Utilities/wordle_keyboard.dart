// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, avoid_print, avoid_function_literals_in_foreach_calls, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ireo/Utilities/wordle_board.dart';
import 'package:ireo/Utilities/wordle_provider.dart';

class WordleKeyboard extends StatefulWidget {
  WordleKeyboard(this.game, {Key? key}) : super(key: key);
  Wordle game;
  @override
  State<WordleKeyboard> createState() => _WordleKeyboardState();
}

class _WordleKeyboardState extends State<WordleKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(Wordle.game_msg, style: TextStyle(color: Colors.white)),
      SizedBox(
        height: 20.0,
      ),
      WordleBoard(widget.game),
      SizedBox(
        height: 40.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: row1.map((e) {
          return InkWell(
            onTap: () {
              print(e);
              if (widget.game.letterID < 5) {
                setState(() {
                  widget.game.insertWord(widget.game.letterID, Letter(e, 0));
                  widget.game.letterID++;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: Text(
                "$e",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: row2.map((e) {
          return InkWell(
            onTap: () {
              print(e);
              if (widget.game.letterID < 5) {
                setState(() {
                  widget.game.insertWord(widget.game.letterID, Letter(e, 0));
                  widget.game.letterID++;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: Text(
                "$e",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: row3.map((e) {
          return InkWell(
            onTap: () {
              print(e);
              if (e == "DEL") {
                if (widget.game.letterID > 0) {
                  setState(() {
                    widget.game
                        .insertWord(widget.game.letterID - 1, Letter("", 0));
                    widget.game.letterID--;
                  });
                }
              } else if (e == "SUBMIT") {
                if (widget.game.letterID >= 5) {
                  String guess = widget.game.board[widget.game.rowID]
                      .map((e) => e.letter)
                      .join();
                  if (widget.game.checkWordExist(guess)) {
                    if (guess == Wordle.game_guess) {
                      setState(() {
                        Wordle.game_msg = "Congrats!";
                        widget.game.board[widget.game.rowID].forEach((element) {
                          element.code = 1;
                        });
                      });
                    } else {
                      for (int i = 0; i < guess.length; i++) {
                        String char = guess[i];
                        if (Wordle.game_guess.contains(char)) {
                          if (Wordle.game_guess[i] == char) {
                            setState(() {
                              widget.game.board[widget.game.rowID][i].code = 1;
                            });
                          } else {
                            setState(() {
                              widget.game.board[widget.game.rowID][i].code = 2;
                            });
                          }
                        }
                      }
                      widget.game.rowID++;
                      widget.game.letterID = 0;
                    }
                  } else {
                    Wordle.game_msg =
                        "The word does not exist! Input another word...";
                    Text(Wordle.game_msg,
                        style: TextStyle(color: Colors.white));
                  }
                }
              } else {
                if (widget.game.letterID < 5) {
                  setState(() {
                    widget.game.insertWord(widget.game.letterID, Letter(e, 0));
                    widget.game.letterID++;
                  });
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: Text(
                "$e",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      )
    ]);
  }
}
