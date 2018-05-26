import 'package:meta/meta.dart';

@immutable
class DraggableData {
  DraggableData({
    @required this.letter,
  })  : assert(letter != null),
        assert(letter.length == 1);

  final String letter;
}
