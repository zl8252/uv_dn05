import 'package:flutter/material.dart';

import 'package:uv_dn05/data/all.dart';

class BigLetter extends StatelessWidget {
  BigLetter({
    @required this.backgroundColor,
    @required this.letter,
  })  : assert(backgroundColor != null),
        assert(letter != null);

  final Color backgroundColor;

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 100.0,
      height: 100.0,
      color: backgroundColor,
      child: new Center(
        child: new Text(
          letter.letter,
          style: new TextStyle(
            color: Colors.black,
            inherit: false,
            fontSize: 50.0,
          ),
        ),
      ),
    );
  }
}
