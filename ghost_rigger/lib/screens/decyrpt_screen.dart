import 'package:flutter/material.dart';
import '../animation/console_animation.dart';

import '../main.dart';

class DecryptScreen extends StatefulWidget {
  @override
  _DecryptScreenState createState() => _DecryptScreenState();
}

class _DecryptScreenState extends State<DecryptScreen> {
  bool _showContinue = false;
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
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 9,
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: getContent(),
                ),
              ),
              Flexible(
                flex: 2,
                child: _showContinue
                    ? FlatButton(
                        onPressed: () => setState(() {
                          Navigator.pushReplacementNamed(
                              context, '/level$nextLevel');
                        }),
                        child: Image.asset(
                          'assets/images/intro_button_continue.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  List<String> getText() {
    switch (Main.currentLevel) {
      case 2:
        return [
          "Great! You have now intercepted the messages sent by NDI.\n\n",
          "But they seem to be encrypted, as expected.\n\n",
          "Nothing you cannot deal with...",
        ];
      case 3:
      default:
        return [
          "DECRYPTING MESSAGE...\n\n",
          "-- START OF MESSAGE --\n\n",
          "The first prototypes for the new Super Pollutant Power Plant™ are ready to start the tests.\n\n",
          "If they are successful, the plan to replace 5000 wind mills with these new oil-fired power plants will go ahead.\n\n",
          "-- END OF MESSAGE --",
        ];
    }
  }

  ConsoleAnimatedTextKit getContent() {
    var consoleAnimatedTextKit = ConsoleAnimatedTextKit(
      displayFullTextOnTap: true,
      text: getText(),
      onFinished: () => setState(() {
        _showContinue = true;
      }),
      textStyle: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Rajdhani',
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
      alignment: Alignment.topCenter,
    );

    consoleAnimatedTextKit.createState();
    return consoleAnimatedTextKit;
  }
}
