import 'package:flutter/material.dart';
import '../animation/typewroter.dart';

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
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(color: Colors.black),
          child: SizedBox(
            width: 250.0,
            child: TypewriterAnimatedTextKit2(
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
                  fontSize: 30.0,
                  fontFamily: "Agne",
                ),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
        ),
        _showContinue
            ? FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Continue'),
              )
            : Container(),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Exit'),
        ),
      ],
    );
  }
}
