import 'package:flutter/material.dart';
import '../animation/console_animation.dart';
import '../audio.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _showContinue = false;
  int _introNumber = 1;

  @override
  void initState() {
    super.initState();
    Audio.play(Song.DRAMATIC);
    _introNumber = 1;
    _showContinue = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage("assets/images/intro_image_screen$_introNumber.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: <Widget>[
          if (_introNumber == 2)
            Expanded(
              flex: 1,
              child: Container(),
            ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: _introNumber != 2
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: FlatButton(
                    padding: EdgeInsets.all(20.0),
                    onPressed: () {
                      Navigator.pop(context);
                      Audio.play(Song.MENU);
                    },
                    child: Image.asset(
                      'assets/images/intro_icon_exit.png',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
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
                            if (_introNumber < 3) {
                              _introNumber = _introNumber % 4 + 1;
                              _showContinue = false;
                            } else {
                              Audio.playSfx("menu.aac");
                              Navigator.of(context)
                                  .pushReplacementNamed('/chat');
                            }
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
          if (_introNumber != 2)
            Expanded(
              flex: 1,
              child: Container(),
            ),
        ],
      ),
    );
  }

  List<String> getText() {
    switch (_introNumber) {
      case 2:
        return [
          "While they look for new evil ways to increase their margins and satisfy their never-ending greed,\n\n"
              .toUpperCase(),
          "a group of hackers are trying to stop them.\n\n".toUpperCase(),
          "They call themselves Unanymous.\n".toUpperCase(),
        ];
      case 3:
        return [
          "Within them,\n\n".toUpperCase(),
          "those who focus their efforts on fighting against NDI's injustices are known as *ghost riggers*.\n\n"
              .toUpperCase(),
          "You are the best one...\n".toUpperCase(),
        ];
      case 1:
      default:
        return [
          "In the year 2078,\n\n".toUpperCase(),
          "the mega-corporation Native Development Initiative, aka NDI...\n\n"
              .toUpperCase(),
          "rules the Earth.\n".toUpperCase(),
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
