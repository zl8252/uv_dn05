import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

import 'draggables/all.dart';
import 'items/all.dart';

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

  List<DraggableLetter> _draggableLetters;

  @override
  void initState() {
    super.initState();

    _currentWordIndex = 0;
    _draggableLetters = _createDraggableLetters();
  }

  Word get currentWord => widget.gameProperties.words[_currentWordIndex];

  List<DraggableLetter> _createDraggableLetters() {
    return <DraggableLetter>[
      new DraggableLetter(
          initialPosition: new Offset(300.0, 300.0),
          data: new DraggableData(letter: "A"),
          onDraggedToSuccess: (draggableLetter) {
            setState(() {
              _draggableLetters.remove(draggableLetter);
            });
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildTopRow(),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Top Row -------------------------------------------------------------------

  Widget buildTopRow() {
    List<Widget> columns = <Widget>[];

    // left column
    List<Widget> leftColumnItems = <Widget>[];

    if (widget.gameProperties.showWord) {
      List<Widget> wordRowItems = <Widget>[];
      for (Letter letter
          in currentWord.asLetters(widget.gameProperties.upperCased)) {
        BigLetter bigLetter = new BigLetter(
          backgroundColor: Colors.transparent,
          letter: letter,
        );
        wordRowItems.add(bigLetter);
      }

      leftColumnItems.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: wordRowItems,
        ),
      );
    }

    columns.add(
      new Column(
        children: leftColumnItems,
      ),
    );

    // TODO here (Add Draggable Targets)

    // right column
    if (widget.gameProperties.showGraphic) {
      columns.add(
        new Center(
          child: new Image.asset(
            currentWord.graphic,
            width: 150.0,
          ),
        ),
      );
    }

    return new Row(
      children: columns,
    );
  }
}
