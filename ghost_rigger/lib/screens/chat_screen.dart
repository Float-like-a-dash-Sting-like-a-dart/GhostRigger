import 'dart:async';

import 'package:flutter/material.dart';
import '../animation/console_animation.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 500),
      () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, border: Border.all(color: Colors.cyanAccent)),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.black, border: Border.all(color: Colors.cyan)),
            child: Flexible(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: OutlineButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      borderSide: BorderSide(color: Colors.cyanAccent),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0)),
                      child: Text(
                        'close',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontFamily: 'JetBrainsMono',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'User@Flutt3r',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontFamily: 'JetBrainsMono',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      'Encryption: Secure',
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontFamily: 'JetBrainsMono',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              controller: _controller,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
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
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.cyanAccent)),
            child: Flexible(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'close',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontFamily: 'JetBrainsMono',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'User@Flutt3r',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontFamily: 'JetBrainsMono',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: OutlineButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      borderSide: BorderSide(color: Colors.cyanAccent),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0)),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontFamily: 'JetBrainsMono',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
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
