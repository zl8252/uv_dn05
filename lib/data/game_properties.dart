import 'package:meta/meta.dart';

import 'word.dart';

@immutable
class GameProperties {
  GameProperties({
    @required this.showGraphic,
    @required this.showWord,
    @required this.showHint,
    @required this.makeSound,
    @required this.upperCased,
    @required this.words,
  });

  final bool showGraphic;

  final bool showWord;

  final bool showHint;

  final bool makeSound;

  final bool upperCased;

  final List<Word> words;

  GameProperties copyWith({
    bool showGraphic,
    bool showWord,
    bool showHint,
    bool makeSound,
    bool upperCased,
    List<Word> words,
  }) {
    return new GameProperties(
      showGraphic: showGraphic ?? this.showGraphic,
      showWord: showWord ?? this.showWord,
      showHint: showHint ?? this.showHint,
      makeSound: makeSound ?? this.makeSound,
      upperCased: upperCased ?? this.upperCased,
      words: words ?? this.words,
    );
  }
}
