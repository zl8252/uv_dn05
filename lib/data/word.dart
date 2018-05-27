import 'package:meta/meta.dart';

import 'letter.dart';

@immutable
class Word {
  const Word({
    @required this.word,
    @required this.graphic,
  })  : assert(word != null),
        assert(graphic != null);

  final String word;
  final String graphic;

  List<Letter> asLetters(bool uperCase) {
    List<Letter> r = <Letter>[];
    for (int i = 0; i < word.length; i++) {
      String l = word[i];
      if (uperCase) {
        l = l.toUpperCase();
      }

      Letter letter = new Letter(letter: l);

      r.add(letter);
    }

    return r;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Word &&
              runtimeType == other.runtimeType &&
              word == other.word;

  @override
  int get hashCode => word.hashCode;



}
