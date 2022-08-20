// ignore_for_file: prefer_const_constructors, implementation_imports, unnecessary_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ireo/Utilities/worlde_provider.dart';

class WordleBoard extends StatefulWidget {
  WordleBoard(this.game, {Key? key}) : super(key: key);
  Wordle game;
  @override
  State<WordleBoard> createState() => _WordleBoardState();
}

class _WordleBoardState extends State<WordleBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.game.board
          .map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: e
                    .map((e) => Container(
                          padding: EdgeInsets.all(16.0),
                          width: 64.0,
                          height: 64.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: e.code == 0
                                  ? Colors.grey[800]
                                  : e.code == 1
                                      ? Colors.green[400]
                                      : Colors.amber[400]),
                          child: Center(
                            child: Text(
                              e.letter!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}
