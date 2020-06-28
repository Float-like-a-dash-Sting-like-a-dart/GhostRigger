import 'package:flutter/material.dart';
import '../animation/console_animation.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'User@Flutt3r',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontFamily: 'JetBrainsMono',
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Encryption: Secure.',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontFamily: 'JetBrainsMono',
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 7,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ConsoleAnimatedTextKit(
                    displayFullTextOnTap: true,
                    text: [
                      "> C1ph3r: Zer0 came back with some news, it seems like NDI are up to something.\n\n",
                      "> Mr. V1ruS: They always are! What is it this time?\n\n",
                      "> C1ph3r: We still don't know, we haven't been able to decrypt their messages. They have improved their encryption mechanism.\n\n",
                      "> Mr. V1ruS: Sounds like a challenge...\n\n",
                      "> R00t: No offence, Mr. V1rus, but we'll need someone *actually* capable of hacking the mainframe.\n\n",
                      "> Mr. V1rus: LOL, none taken. In all fairness, only one of us has what this task takes...\n\n",
                      "> R00t: You are absolutely right. Flutt3r, I know you are reading. Are you up for the challenge?\n\n",
                    ],
                    onFinished: () {
                      var _showContinue = true;
                    },
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'JetBrainsMono',
                    ),
                    textAlign: TextAlign.left,
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
