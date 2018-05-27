import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

import 'game_level.dart';

class GamePage extends StatefulWidget {
  GamePage({
    @required this.gameProperties,
    @required this.onExitGame,
  })  : assert(gameProperties != null),
        assert(onExitGame != null);

  final GameProperties gameProperties;

  final VoidCallback onExitGame;

  @override
  _GamePageState createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Word> _words;

  int _currentWordIndex;

  @override
  void initState() {
    super.initState();

    _words = widget.gameProperties.words;
    _words.shuffle();

    _currentWordIndex = 0;
  }

  Word get _currentWord => _words[_currentWordIndex];

  void _onLevelCompleted() {
    int wordIndex = _currentWordIndex;
    wordIndex++;

    if (wordIndex == _words.length) {
      widget.onExitGame();
      return;
    }

    setState(() {
      _currentWordIndex = wordIndex;
    });
  }

  void _onExitButtonPressed() {
    print("Exit button pressed");
    widget.onExitGame();
  }

  @override
  Widget build(BuildContext context) {
    return new GameLevel(
      gameProperties: widget.gameProperties,
      word: _currentWord,
      onLevelCompleted: _onLevelCompleted,
      onExitButtonPressed: _onExitButtonPressed,
    );
  }
}
