import 'package:flutter/material.dart';

import 'main_page.dart';

void main() {
  runApp(new StylePage());
}

class StylePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Pisalnik",
      home: new MainPage(),
    );
  }
}
