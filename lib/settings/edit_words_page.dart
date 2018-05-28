import 'package:flutter/material.dart';

import 'package:uv_dn05/data/all.dart';

class EditWordsPage extends StatefulWidget {
  EditWordsPage({
    @required this.initialGameProperties,
    @required this.onCompleted,
  })  : assert(initialGameProperties != null),
        assert(onCompleted != null);

  final GameProperties initialGameProperties;

  final ValueChanged<GameProperties> onCompleted;

  @override
  _EditWordsPageState createState() => new _EditWordsPageState();
}

class _EditWordsPageState extends State<EditWordsPage> {
  GameProperties _gameProperties;

  TextEditingController _textEditingControllerWord;

  TextEditingController _textEditingControllerURL;

  @override
  void initState() {
    super.initState();

    _textEditingControllerWord = new TextEditingController();

    _textEditingControllerURL = new TextEditingController();

    _gameProperties = widget.initialGameProperties;
  }

  void _addWord() {
    String word = _textEditingControllerWord.text;
    String url = _textEditingControllerURL.text;

    if (word == "") {
      return;
    }

    if (url == "") {
      return;
    }

    Word w = new Word(word: word, graphic: url);

    setState(() {
      _textEditingControllerWord.text = "";
      _textEditingControllerURL.text = "";

      _gameProperties.words.add(w);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          _buildAppBar(),
          new Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
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
            "Besede",
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
          ),
          new RaisedButton(
            onPressed: () {
              widget.onCompleted(_gameProperties);
            },
            child: new Text("Shrani"),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    "Beseda:",
                    style: new TextStyle(fontSize: 21.0),
                  ),
                  new Expanded(
                      child: new TextField(
                    controller: _textEditingControllerWord,
                  )),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    "URL:",
                    style: new TextStyle(fontSize: 21.0),
                  ),
                  new Expanded(
                      child: new TextField(
                    controller: _textEditingControllerURL,
                  )),
                ],
              ),
              new Container(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new RaisedButton(
                    child: new Text("Dodaj besedo"),
                    onPressed: () {
                      _addWord();
                    }),
              ),
            ],
          ),
        ),
        new Divider(),
        new Expanded(
            child: new SingleChildScrollView(
          child: _buildListOfWords(),
        )),
      ],
    );
  }

  Widget _buildListOfWords() {
    Widget buildImage(String url) {
      if (url.startsWith("http")) {
        return new Image.network(
          url,
          width: 50.0,
        );
      } else {
        return new Image.asset(
          url,
          width: 50.0,
        );
      }
    }

    return new Column(
      children: _gameProperties.words.map((Word word) {
        return new Column(
          children: <Widget>[
            new Container(
              padding:
                  new EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                      word.word,
                      style: new TextStyle(fontSize: 25.0),
                    ),
                    buildImage(word.graphic),
                    new RaisedButton(
                      child: new Text("Izbriši"),
                      onPressed: () {
                        setState(() {
                          _gameProperties.words.remove(word);
                        });
                      },
                    ),
                  ]),
            ),
            new Divider(),
          ],
        );
      }).toList(),
    );
  }
}
