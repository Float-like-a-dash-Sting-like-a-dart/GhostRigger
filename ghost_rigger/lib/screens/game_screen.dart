import 'package:flutter/material.dart';
import 'package:ghost_rigger/screens/hacking_device.dart';
import 'package:ghost_rigger/screens/models/level_model.dart';

import '../audio.dart';
import '../main.dart';
import 'models/piece_model.dart';
import 'models/puzzle_model.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Widget build(context) {
    var validCellPositions = [
      [1, 2], [1, 3], [1, 4],
      [2, 2], [2, 3], [2, 4],
    ];
    var pieceModels = [
      PieceModel(isInOrOut: true, arithmeticValue: 3, positionInBoardRow: 2, positionInBoardColumn: 1),
      PieceModel(isInOrOut: true, positionInBoardRow: 1, positionInBoardColumn: 5),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(hastBottomCable: true, hastRightCable: true, arithmeticValue: 1, arithmeticOperation: ArithmeticOperation.add),
      PieceModel(hastLeftCable: true, hastRightCable: true, arithmeticValue: 2, arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(hastLeftCable: true, hastTopCable: true, positionInBoardRow: 2, positionInBoardColumn: 2),
    ];
    var puzzle = PuzzleModel(validCellPositions, pieceModels, 8);


    var level = LevelModel(
        [
          puzzle,
          puzzle, // TODO Use a different puzzle
        ],
        'Tuning in',
        'It seems like your radio receptor isn\'t tuned correctly to intercept the messages sent by the NDI (Native Development Initiative). Try placing some modules on the board of this hacking device to get the desired output.');


    Main.game = HackingDevice(
        level, () {
          Main.game = null;
          Audio.play(Song.MENU);
          Navigator.pop(context);
        }, () { });
    Audio.play(Song.GAME);
    return Main.game.widget;
  }
}
