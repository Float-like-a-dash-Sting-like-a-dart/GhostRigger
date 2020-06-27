import 'package:flutter/material.dart';
import '../animation/typewroter.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: SizedBox(
            width: 250.0,
            child: TypewriterAnimatedTextKit2(
                onTap: () {
                  print("Tap Event");
                },
                displayFullTextOnTap: true,
                text: [
                  "In the year 2078,"
                      "the megacorporation *Native Development Initiative*, aka NDI,",
                  "rules the Earth.",
                ],
                onFinished: () {},
                textStyle: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Agne",
                ),
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
