import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      congratsSoundURL:
          "https://raw.githubusercontent.com/zl8252/uv_dn05/master/sounds/correct.mp3",
      words: initialWords,
    );
  }

  Future<Null> _showGamePage() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (_) {
          return new GamePage(
            gameProperties: _gameProperties,
            onExitGame: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  Future<Null> _showSettingsPage() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new SettingsPage(
            initialGameProperties: _gameProperties,
            onSettingsCompleted: (GameProperties newGameProperties) {
              Navigator.of(context).pop();

              setState(() {
                _gameProperties = newGameProperties;
              });
            });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Removes top bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // settings button
          new Positioned(
            top: 0.0,
            left: 0.0,
            child: new GestureDetector(
              child: new Icon(Icons.settings),
              onLongPress: () {
                print("Opening Settings Page");
                _showSettingsPage();
              },
            ),
          ),
          // main
          new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  "Pisalnik",
                  style: new TextStyle(
                      fontSize: 50.0, fontWeight: FontWeight.w600),
                ),
                new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new FlatButton(
                    onPressed: () {
                      print("Opening Game Page");
                      _showGamePage();
                    },
                    child: new Image.asset(
                      "graphics/play_button.png",
                      width: 70.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
