import 'dart:async';

import 'package:flutter/material.dart';
import '../audio.dart';
import '../controls/blinking_button.dart';
import '../animation/console_animation.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _messageText = '';
  var _showSendButton = false;

  @override
  Widget build(BuildContext context) {
    Audio.stop();
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
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed('/level1'),
                      borderSide: BorderSide(color: Colors.cyanAccent),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0)),
                      child: Text(
                        'Skip',
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
                    child: OutlineButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 15.0),
                      onPressed: () => {},
                      color: Colors.purpleAccent,
                      highlightedBorderColor: Colors.purpleAccent,
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0.0)),
                      child: Text(
                        'Encryption: Secure',
                        style: TextStyle(
                          color: Colors.purpleAccent,
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
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ConsoleAnimatedTextKit(
                    speed: Duration(milliseconds: 3),
                    pause: Duration(milliseconds: 2500),
                    displayFullTextOnTap: true,
                    text: [
                      "> C1ph3r: Zer0 came back with some news, it seems like NDI are up to something.\n\n",
                      "> Mr. V1ruS: They always are! What is it this time?\n\n",
                      "> C1ph3r: We still don't know, we haven't been able to decrypt their messages. They have improved their encryption mechanism.\n\n",
                      "> Mr. V1ruS: Sounds like a challenge...\n\n",
                      "> R00t: No offence, Mr. V1rus, but we'll need someone *actually* capable of hacking the mainframe.\n\n",
                      "> Mr. V1rus: LOL, none taken. In all fairness, only one of us has what this task takes...\n\n",
                      "> R00t: You are absolutely right. Flutt3r, I know you are reading. Are you up for the challenge?\n",
                    ],
                    onFinished: () => setState(
                      () {
                        _messageText = "Leave it to me!";
                      },
                    ),
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.cyan)),
                    child: Flexible(
                      flex: 2,
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        onPressed: null,
                        borderSide: BorderSide(color: Colors.cyanAccent),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0.0)),
                        child: Text(
                          'Message:',
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontFamily: 'JetBrainsMono',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ConsoleAnimatedTextKit(
                        displayFullTextOnTap: false,
                        text: [
                          _messageText,
                        ],
                        onFinished: () => setState(
                          () {
                            if (_messageText.isNotEmpty) {
                              _showSendButton = true;
                            }
                          },
                        ),
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'JetBrainsMono',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.cyanAccent)),
                    child: Flexible(
                      flex: 2,
                      child: _showSendButton
                          ? BlinkingButton(
                              () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/level1');
                              },
                            )
                          : OutlineButton(
                              padding: EdgeInsets.all(8.0),
                              onPressed: null,
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
