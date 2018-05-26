import 'package:meta/meta.dart';

@immutable
class Letter {
  Letter({
    @required this.letter,
  })  : assert(letter != null),
        assert(letter.length == 1);

  final String letter;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Letter &&
          runtimeType == other.runtimeType &&
          letter == other.letter;

  @override
  int get hashCode => letter.hashCode;
}
