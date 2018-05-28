import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:uv_dn05/data/all.dart';

import 'draggables/all.dart';
import 'items/all.dart';

class GameLevel extends StatefulWidget {
  GameLevel({
    @required this.gameProperties,
    @required this.word,
    @required this.onLevelCompleted,
    @required this.onExitButtonPressed,
  })  : assert(gameProperties != null),
        assert(word != null),
        assert(onLevelCompleted != null),
        assert(onExitButtonPressed != null),
        super(key: new Key(word.word));

  final GameProperties gameProperties;

  final Word word;

  final VoidCallback onLevelCompleted;

  final VoidCallback onExitButtonPressed;

  @override
  _GameLevelState createState() => new _GameLevelState();
}

class _GameLevelState extends State<GameLevel> {
  static const EdgeInsets _targetLetterPadding =
      const EdgeInsets.symmetric(horizontal: 8.0);

  List<DraggableLetterItem> _draggableItems;

  AudioPlayer _audioPlayer;

  int playerState;

  @override
  void initState() {
    super.initState();

    _audioPlayer = new AudioPlayer();

    _audioPlayer.setDurationHandler((d) {});

    _audioPlayer.setPositionHandler((p) {});

    _audioPlayer.setCompletionHandler(() {});

    _audioPlayer.setErrorHandler(print);

    _draggableItems = _createDraggableItems();
  }

  List<Letter> get letters =>
      widget.word.asLetters(widget.gameProperties.upperCased);

  List<DraggableLetterItem> _createDraggableItems() {
    List<DraggableLetterItem> r = letters.map((Letter letter) {
      return new DraggableLetterItem(
        letter: letter,
        child: new BigLetter(
          backgroundColor: Colors.grey[300],
          letter: letter,
        ),
        feedback: new BigLetter(
          backgroundColor: Colors.blue[200],
          letter: letter,
        ),
        onDragCompleted: _onDragCompleted,
      );
    }).toList();

    r.shuffle();

    return r;
  }

  void _onDragCompleted(DraggableLetterItem draggableLetterItem) {
    _playCongratsSound();

    setState(() {
      _draggableItems.remove(draggableLetterItem);
      if (_draggableItems.length == 0) {
        _onLevelCompleted();
      }
    });
  }

  _playCongratsSound() async {
    try {
      if (widget.gameProperties.makeSound) {
        final result = await _audioPlayer
            .play(widget.gameProperties.congratsSoundURL, isLocal: false);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _onLevelCompleted() async {
    print("Level Completed");

    await new Future.delayed(new Duration(
      seconds: 1,
    ));
    widget.onLevelCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // exit button
          new Positioned(
              top: 0.0,
              left: 0.0,
              child: new FlatButton(
                onPressed: widget.onExitButtonPressed,
                child: new Image.asset(
                  "graphics/back_arrow.png",
                  height: 30.0,
                ),
              )),
          // content
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildTopRow(),
                  _buildBottomRow(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    List<Widget> columns = <Widget>[];

    // left column
    List<Widget> leftColumnItems = <Widget>[];

    // word
    if (widget.gameProperties.showWord) {
      leftColumnItems.add(_buildWord());
    }

    // targets
    leftColumnItems.add(_buildTargetsWidget());

    columns.add(
      new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: leftColumnItems,
      ),
    );

    // right column
    if (widget.gameProperties.showGraphic) {
      Widget image;
      if (widget.word.graphic.startsWith("http")) {
        image = new Image.network(
          widget.word.graphic,
          width: 150.0,
        );
      } else {
        image = new Image.asset(
          widget.word.graphic,
          width: 150.0,
        );
      }

      columns.add(
        new Center(
          child: image,
        ),
      );
    }

    return new Row(
      children: columns,
    );
  }

  Widget _buildWord() {
    return new Row(
      children: letters
          .map(
            (letter) => new Container(
                  padding: _targetLetterPadding,
                  child: new BigLetter(
                    backgroundColor: Colors.transparent,
                    letter: letter,
                  ),
                ),
          )
          .toList(),
    );
  }

  Widget _buildTargetsWidget() {
    return new Container(
      padding: new EdgeInsets.only(top: 16.0),
      child: new Row(
        children: letters.map(
          (letter) {
            return new DraggableLetterTarget(
              targetLetter: letter,
              targetChild: new Container(
                padding: _targetLetterPadding,
                child: new BigLetter(
                  backgroundColor: Colors.green[300],
                  letter: widget.gameProperties.showHint
                      ? letter
                      : new Letter(letter: "_"),
                ),
              ),
              targetHitChild: new Container(
                padding: _targetLetterPadding,
                child: new BigLetter(
                  backgroundColor: Colors.red[200],
                  letter: letter,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildBottomRow() {
    return new Container(
      padding: new EdgeInsets.only(top: 32.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _draggableItems
            .map(
              (item) => new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 16.0),
                    child: item,
                  ),
            )
            .toList(),
      ),
    );
  }
}
