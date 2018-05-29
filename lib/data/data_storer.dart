import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'game_properties.dart';
import 'word.dart';

const _key_gameProperties = "gameProperties";

Future<bool> saveGameProperties(
  GameProperties gameProperties,
) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  String jsonString = _gamePropertiesToJson(gameProperties);

  return await sharedPreferences.setString(
    _key_gameProperties,
    jsonString,
  );
}

Future<GameProperties> loadGameProperties() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  String jsonString = sharedPreferences.getString(_key_gameProperties);

  if (jsonString == null) {
    return null;
  } else {
    return _jsonToGameProperties(jsonString);
  }
}

String _gamePropertiesToJson(GameProperties gameProperties) {
  Map<String, dynamic> map = <String, dynamic>{
    "showGraphic": gameProperties.showGraphic,
    "showWord": gameProperties.showWord,
    "showHint": gameProperties.showHint,
    "makeSound": gameProperties.makeSound,
    "upperCased": gameProperties.upperCased,
    "congratsSoundURL": gameProperties.congratsSoundURL,
    "words": gameProperties.words
        .map<Map<String, String>>(
          (word) => <String, String>{
                "word": word.word,
                "graphic": word.graphic,
              },
        )
        .toList(),
  };

  return json.encode(map);
}

GameProperties _jsonToGameProperties(String jsonString) {
  Map<String, dynamic> map = json.decode(jsonString);

  return new GameProperties(
    showGraphic: map["showGraphic"],
    showWord: map["showWord"],
    showHint: map["showHint"],
    makeSound: map["makeSound"],
    upperCased: map["upperCased"],
    congratsSoundURL: map["congratsSoundURL"],
    words: (map["words"] as List)
        .map(
          (wordMap) => new Word(
                word: wordMap["word"],
                graphic: wordMap["graphic"],
              ),
        )
        .toList(),
  );
}
