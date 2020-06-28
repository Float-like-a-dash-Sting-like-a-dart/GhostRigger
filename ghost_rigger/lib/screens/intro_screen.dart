import 'package:flutter/material.dart';
import '../animation/console_animation.dart';
import '../audio.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _showContinue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Audio.play(Song.INTRO);
    return Container(
      decoration: new BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConsoleAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              displayFullTextOnTap: true,
              text: [
                "In the year 2078,",
                "the megacorporation *Native Development Initiative*, aka NDI,",
                "rules the Earth.",
              ],
              onFinished: () {
                setState(() {
                  _showContinue = true;
                });
              },
              textStyle: TextStyle(
                fontSize: 20.0,
                fontFamily: 'JetBrainsMono',
              ),
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
          _showContinue
              ? FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Exit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
