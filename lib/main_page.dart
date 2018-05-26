import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uv_dn05/data/all.dart';
import 'package:uv_dn05/game/all.dart';
import 'package:uv_dn05/settings/all.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GameProperties _gameProperties;

  @override
  void initState() {
    super.initState();

    _gameProperties = new GameProperties(
      showGraphic: true,
      showWord: true,
      showHint: true,
      makeSound: true,
      upperCased: true,
      words: initialWords,
    );
  }

  Future<Null> _showGamePage() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (_) {
          return new GamePage(
            gameProperties: _gameProperties,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new RaisedButton(
            child: new Text("Play"),
            onPressed: () {
              _showGamePage();
            },
          ),
        ],
      ),
    );
  }
}
