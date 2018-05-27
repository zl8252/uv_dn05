import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:uv_dn05/data/all.dart';

typedef void DraggableLetterItemCallback(
  DraggableLetterItem draggableLetterItem,
);

class DraggableLetterItem extends StatefulWidget {
  DraggableLetterItem({
    @required this.letter,
    @required this.child,
    @required this.feedback,
    @required this.onDragCompleted,
  })  : assert(letter != null),
        assert(child != null),
        assert(feedback != null),
        assert(onDragCompleted != null);

  final Letter letter;

  final Widget child;

  final Widget feedback;

  final DraggableLetterItemCallback onDragCompleted;

  @override
  _DraggableLetterItemState createState() => new _DraggableLetterItemState();
}

class _DraggableLetterItemState extends State<DraggableLetterItem> {
  @override
  Widget build(BuildContext context) {
    return new Draggable<Letter>(
      data: widget.letter,
      child: widget.child,
      feedback: widget.feedback,
      onDragCompleted: () {
        widget.onDragCompleted(widget);
      },
    );
  }
}
