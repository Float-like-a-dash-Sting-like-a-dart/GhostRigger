import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: SizedBox(
            width: 250.0,
            child: TypewriterAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "Thanks for playing our game prototype until the end.",
                  "If you liked it, please give us your vote!",
                  "Created by:",
                  "Iain Smith (Development)",
                  "Julio Ernesto Rodríguez Cabañas (Development)",
                  "Richard Kinsella (Design)",
                ],
                textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Continue'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Exit'),
        ),
      ],
    );
  }
}
