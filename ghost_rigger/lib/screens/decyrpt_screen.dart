import 'package:flutter/material.dart';

import '../main.dart';

class DecryptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int nextLevel = ModalRoute.of(context).settings.arguments;

    Main.currentLevel = nextLevel;
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/chat_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: OutlineButton(
        padding: EdgeInsets.all(0.0),
        color: Colors.transparent,
        highlightedBorderColor: Colors.transparent,
        onPressed: () =>
            Navigator.pushReplacementNamed(context, '/level$nextLevel'),
        child: null,
      ),
    );
  }
}
