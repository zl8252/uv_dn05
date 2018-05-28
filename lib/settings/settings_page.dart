import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

import 'edit_words_page.dart';

typedef void OnSettingsCompleted(
  GameProperties updatedGameProperties,
);

class SettingsPage extends StatefulWidget {
  SettingsPage({
    @required this.initialGameProperties,
    @required this.onSettingsCompleted,
  })  : assert(initialGameProperties != null),
        assert(onSettingsCompleted != null);

  final GameProperties initialGameProperties;

  final OnSettingsCompleted onSettingsCompleted;

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GameProperties _gameProperties;

  TextEditingController _congratsSoundTextEditingController;

  @override
  void initState() {
    super.initState();

    _gameProperties = widget.initialGameProperties;

    _congratsSoundTextEditingController =
        new TextEditingController(text: _gameProperties.congratsSoundURL);
  }

  Future<Null> _onEditWordsButton() async {
    await Navigator.of(context).push(
      new MaterialPageRoute(builder: (_) {
        return new EditWordsPage(
            initialGameProperties: _gameProperties,
            onCompleted: (GameProperties newGameProperties) {
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
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        _buildAppBar(),
        new Expanded(child: _buildBody()),
      ],
    ));
  }

  Widget _buildAppBar() {
    return new Container(
      padding: new EdgeInsets.only(top: 32.0),
      height: 82.0,
      color: Colors.blue[200],
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(
            "Nastavitve",
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
          ),
          new RaisedButton(
            onPressed: () {
              widget.onSettingsCompleted(_gameProperties);
            },
            child: new Text("Shrani"),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          // Edit Words
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            child: new RaisedButton(
              child: new Text("Urejaj Besede"),
              onPressed: () {
                _onEditWordsButton();
              },
            ),
          ),
          new Divider(),
          // Congrats sound
          _buildChangeCongratsSound(),
          new Divider(),
          // show Graphics
          new SwitchListTile(
            value: _gameProperties.showGraphic,
            title: Text("Prikaži Slike"),
            onChanged: (value) {
              setState(() {
                _gameProperties = _gameProperties.copyWith(showGraphic: value);
              });
            },
          ),
          new Divider(),
          // show Word
          new SwitchListTile(
            value: _gameProperties.showWord,
            title: Text("Prikaži besedo"),
            onChanged: (value) {
              setState(() {
                _gameProperties = _gameProperties.copyWith(showWord: value);
              });
            },
          ),
          new Divider(),
          // show Hint
          new SwitchListTile(
              value: _gameProperties.showHint,
              title: new Text("Prikaži namig"),
              onChanged: (value) {
                setState(() {
                  _gameProperties = _gameProperties.copyWith(showHint: value);
                });
              }),
          new Divider(),
          // make Sound
          new SwitchListTile(
              value: _gameProperties.makeSound,
              title: new Text("Zvok"),
              onChanged: (value) {
                setState(() {
                  _gameProperties = _gameProperties.copyWith(makeSound: value);
                });
              }),
          new Divider(),
          // upper Cased
          new SwitchListTile(
              value: _gameProperties.upperCased,
              title: new Text("Velike Črke"),
              onChanged: (value) {
                setState(() {
                  _gameProperties = _gameProperties.copyWith(upperCased: value);
                });
              }),
          new Divider(),
        ],
      ),
    );
  }

  Widget _buildChangeCongratsSound() {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: new Row(
        children: <Widget>[
          new Text(
            "Zvok URL:",
            style: new TextStyle(fontSize: 16.0),
          ),
          new Container(
            padding: new EdgeInsets.only(right: 16.0),
          ),
          new Expanded(
              child: new TextField(
            controller: _congratsSoundTextEditingController,
          )),
          new Container(
            padding: new EdgeInsets.only(left: 21.0, right: 18.0),
            child: new RaisedButton(
                child: new Text("Posodobi"),
                onPressed: () {
                  setState(() {
                    _gameProperties = _gameProperties.copyWith(
                        congratsSoundURL:
                            _congratsSoundTextEditingController.text);
                  });
                }),
          )
        ],
      ),
    );
  }
}
