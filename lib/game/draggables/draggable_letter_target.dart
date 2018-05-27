import 'package:flutter/material.dart';

import 'package:uv_dn05/data/all.dart';

class DraggableLetterTarget extends StatefulWidget {
  DraggableLetterTarget({
    @required this.targetLetter,
    @required this.targetChild,
    @required this.targetHitChild,
  })  : assert(targetLetter != null),
        assert(targetChild != null),
        assert(targetHitChild != null);

  final Letter targetLetter;

  final Widget targetChild;

  final Widget targetHitChild;

  @override
  _DraggableLetterTargetState createState() =>
      new _DraggableLetterTargetState();
}

class _DraggableLetterTargetState extends State<DraggableLetterTarget> {
  bool isTargetHit = false;

  @override
  Widget build(BuildContext context) {
    return new DragTarget<Letter>(
      onWillAccept: (Letter letter) {
        return letter == widget.targetLetter;
      },
      onAccept: (Letter letter) {
        setState(() {
          isTargetHit = true;
        });
      },
      builder: _dragTargetBuilder,
    );
  }

  Widget _dragTargetBuilder(
    BuildContext context,
    List<Letter> candidateData,
    List rejectedData,
  ) {
    if (isTargetHit) {
      return widget.targetChild;
    } else {
      return widget.targetHitChild;
    }
  }
}
