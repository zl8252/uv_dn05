import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

import 'game_level.dart';

class GamePage extends StatefulWidget {
  GamePage({
    @required this.gameProperties,
  }) : assert(gameProperties != null);

  final GameProperties gameProperties;

  @override
  _GamePageState createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentWordIndex;

  @override
  void initState() {
    super.initState();

    _currentWordIndex = 0;
  }

  Word get _currentWord => widget.gameProperties.words[_currentWordIndex];

  void onLevelCompleted() {
    int wordIndex = _currentWordIndex;
    wordIndex++;
    wordIndex = wordIndex % widget.gameProperties.words.length;

    setState(() {
      _currentWordIndex = wordIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GameLevel(
      gameProperties: widget.gameProperties,
      word: _currentWord,
      onLevelCompleted: onLevelCompleted,
    );
  }
}
