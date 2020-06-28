import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ghost_rigger/animation/console_animation.dart';

class CreditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: FlatButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('menu'));
            },
            child: Image.asset(
              'assets/images/intro_icon_exit.png',
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: SingleChildScrollView(
            child: ConsoleAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "Thanks for playing our game prototype until the end.\n\n",
                  "If you liked it, please give us your vote!\n\n",
                  "Created by:\n\n",
                  "Iain Smith (Development)\n\n",
                  "Julio Ernesto Rodríguez Cabañas (Development)\n\n",
                  "Richard Kinsella (Design)\n\n",
                ],
                textStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "JetBrainsMono",
                    color: Colors.cyanAccent),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
        ),
      ],
    );
  }
}
