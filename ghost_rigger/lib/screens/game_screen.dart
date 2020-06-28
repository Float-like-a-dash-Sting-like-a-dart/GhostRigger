import 'package:flutter/material.dart';
import 'package:ghost_rigger/screens/hacking_device.dart';

import '../audio.dart';
import '../main.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Widget build(context) {
    Main.game = HackingDevice(() {
      Main.game = null;
      Audio.play(Song.MENU);
      Navigator.pop(context);
    });
    Audio.play(Song.GAME);
    return Main.game.widget;
  }
}
