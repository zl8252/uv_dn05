import 'package:flutter/material.dart';

import 'draggable_data.dart';

class DraggableLetterTarget extends StatefulWidget {
  @override
  _DraggableLetterTargetState createState() =>
      new _DraggableLetterTargetState();
}

class _DraggableLetterTargetState extends State<DraggableLetterTarget> {
  @override
  Widget build(BuildContext context) {
    return new DragTarget<DraggableData>(
      onAccept: (DraggableData draggableData) {
        print("Accepted");
      },
      onWillAccept: (DraggableData data) {
        return true;
      },
      builder: _buildContent,
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<DraggableData> candidateData,
    List rejectedData,
  ) {
    return new Container(
      width: 100.0,
      height: 100.0,
      color: Colors.tealAccent,
    );
  }
}
