import 'package:flutter/material.dart';
import '../animation/console_animation.dart';
import '../audio.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _showContinue = false;
  int _introNumber = 0;

  @override
  void initState() {
    super.initState();
    Audio.play(Song.INTRO);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.black),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getContent(),
      ),
    );
  }

  List<Widget> getContent() {
    switch (_introNumber) {
      case 2:
        return [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ConsoleAnimatedTextKit(
                      displayFullTextOnTap: true,
                      text: [
                        "In the year 2078,\n\n",
                        "the mega-corporation Native Development Initiative, aka NDI,\n\n",
                        "rules the Earth...\n\n",
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
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _showContinue
                          ? FlatButton(
                              padding: EdgeInsets.all(20.0),
                              onPressed: () => setState(() {
                                _introNumber = _introNumber + 1;
                              }),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 20.0,
                                  fontFamily: 'JetBrainsMono',
                                ),
                              ),
                            )
                          : Container(),
                      FlatButton(
                        padding: EdgeInsets.all(20.0),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 20.0,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Image.asset(
              'assets/images/cyber_punk_1.png',
              fit: BoxFit.contain,
            ),
          ),
        ];
      case 1:
        return [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ConsoleAnimatedTextKit(
                      displayFullTextOnTap: true,
                      text: [
                        "While they look for new evil ways to increase their margins and satisfy their never-ending greed,\n\n",
                        "a group of hackers are trying to stop them. \n\n",
                        "They call themselves Unanymous.",
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
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _showContinue
                          ? FlatButton(
                              padding: EdgeInsets.all(20.0),
                              onPressed: () => setState(() {
                                _introNumber = _introNumber + 1;
                              }),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 20.0,
                                  fontFamily: 'JetBrainsMono',
                                ),
                              ),
                            )
                          : Container(),
                      FlatButton(
                        padding: EdgeInsets.all(20.0),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 20.0,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Image.asset(
              'assets/images/cyber_punk_1.png',
              fit: BoxFit.contain,
            ),
          ),
        ];
      case 0:
      default:
        return [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ConsoleAnimatedTextKit(
                      displayFullTextOnTap: true,
                      text: [
                        "In the year 2078,\n\n",
                        "the mega-corporation Native Development Initiative, aka NDI,\n\n",
                        "rules the Earth...\n\n",
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
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _showContinue
                          ? FlatButton(
                              padding: EdgeInsets.all(20.0),
                              onPressed: () => setState(() {
                                _introNumber = _introNumber + 1;
                              }),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 20.0,
                                  fontFamily: 'JetBrainsMono',
                                ),
                              ),
                            )
                          : Container(),
                      FlatButton(
                        padding: EdgeInsets.all(20.0),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 20.0,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Image.asset(
              'assets/images/cyber_punk_1.png',
              fit: BoxFit.contain,
            ),
          ),
        ];
    }
  }
}
