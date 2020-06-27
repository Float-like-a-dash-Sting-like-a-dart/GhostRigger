import 'package:flutter/material.dart';
import '../audio.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Audio.play(Song.MENU);
    return Center(
      child: Column(
        children: [
          Text('HELLO'),
          FlatButton(
            child: Text('Game'),
            onPressed: () => Navigator.of(context).pushNamed('/start'),
          ),
          FlatButton(
            child: Text('Credits'),
            onPressed: () => Navigator.of(context).pushNamed('/credits'),
          ),
        ],
      ),
    );
  }
}
