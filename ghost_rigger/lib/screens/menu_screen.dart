import 'package:flutter/material.dart';
import '../audio.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Audio.play(Song.MENU);
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/menu_background_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/logo5.jpg',
            fit: BoxFit.contain,
            width: 120,
          ),
          FlatButton(
            child: Image.asset('assets/images/menu_button_start.png'),
            onPressed: () {
              Audio.playSfx("menu.aac");
              Navigator.of(context).pushNamed('/start');
            },
          ),
          FlatButton(
            child: Text(
              'Resume Game',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Audio.playSfx("menu.aac");
              Navigator.of(context).pushNamed('/resume');
            },
          ),
          FlatButton(
            child: Text(
              'Sound On/Off',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Audio.flipMusicOnOff(),
          ),
          FlatButton(
            child: Image.asset('assets/images/menu_button_about.png'),
            onPressed: () {
              Audio.playSfx("menu.aac");
              Navigator.of(context).pushNamed('/credits');
            },
          ),
          FlatButton(
            child: Text(
              'Credits',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Audio.playSfx("menu.aac");
              Navigator.of(context).pushNamed('/credits');
            },
          ),
        ],
      ),
    );
  }
}
