import 'package:flutter/material.dart';
import '../audio.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();

  bool soundOn;
  MenuScreen(this.soundOn) {}
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    Audio.play(Song.MENU);
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/menu_background_image.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Flexible(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_ghost_rigger.png',
                  fit: BoxFit.contain,
                  width: 300,
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Image.asset(
                    'assets/images/menu_button_start.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  onPressed: () {
                    Audio.playSfx("menu.aac");
                    Navigator.of(context).pushNamed('/start');
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                  child: Image.asset(
                    'assets/images/menu_button_resume.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  onPressed: () {
                    Audio.playSfx("menu.aac");
                    Navigator.of(context).pushNamed('/resume');
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      child: Image.asset(
                        'assets/images/menu_button_about.png',
                        height: 10,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        Audio.playSfx("menu.aac");
                        Navigator.of(context).pushNamed('/newspaper');
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        'assets/images/menu_button_credits.png',
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        Audio.playSfx("menu.aac");
                        Navigator.of(context).pushNamed('/credits');
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        widget.soundOn
                            ? 'assets/images/volume_on.png'
                            : 'assets/images/volume_off.png',
                        height: widget.soundOn ? 15 : 19,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () => {
                        setState(() {
                          widget.soundOn = !widget.soundOn;
                          Audio.flipMusicOnOff();
                        })
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(),
            flex: 6,
          ),
        ],
      ),
    );
  }
}
