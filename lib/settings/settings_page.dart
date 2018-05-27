import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

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

  @override
  void initState() {
    super.initState();

    _gameProperties = widget.initialGameProperties;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        _buildAppBar(),
      ],
    ));
  }

  Widget _buildAppBar() {
    return new Container(
      height: 50.0,
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
}
