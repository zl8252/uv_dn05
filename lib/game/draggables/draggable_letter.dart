import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'draggable_data.dart';

typedef void DraggableLetterCallback(DraggableLetter draggableLetter);

class DraggableLetter extends StatefulWidget {
  DraggableLetter({
    @required this.initialPosition,
    @required this.data,
    @required this.onDraggedToSuccess,
  })  : assert(initialPosition != null),
        assert(data != null);

  final Offset initialPosition;
  final DraggableData data;
  final DraggableLetterCallback onDraggedToSuccess;

  @override
  _DraggableLetterState createState() => new _DraggableLetterState();
}

class _DraggableLetterState extends State<DraggableLetter> {
  Offset position;

  @override
  void initState() {
    super.initState();

    position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: position.dx,
      top: position.dy,
      child: new Draggable<DraggableData>(
        data: widget.data,
        child: buildLetter(),
        onDragCompleted: () {
          widget.onDraggedToSuccess(widget);
        },
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        feedback: buildLetter(),
      ),
    );
  }

  Widget buildLetter() {
    return new Container(
      color: Colors.grey,
      width: 50.0,
      height: 50.0,
      child: new Center(
        child: new Text(widget.data.letter),
      ),
    );
  }
}
