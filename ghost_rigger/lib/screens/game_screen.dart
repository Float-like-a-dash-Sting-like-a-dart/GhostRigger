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

  int level;
  GameScreen(this.level) {}
}

class _GameScreenState extends State<GameScreen> {
  Widget build(context) {
    LevelModel level;

    switch (widget.level) {
      case 1:
        level = LevelModel([
          getPuzzle1(),
        ], 'Tuning in',
            'It seems like your radio receptor isn\'t tuned correctly to intercept the messages sent by the NDI (Native Development Initiative). Try placing some modules on the board of this hacking device to get your output to match the goal. Once you have a solution, click on the Play button on the top left to try it.');
        break;

      case 2:
        level = LevelModel([
          getPuzzle2(),
          getPuzzle3(),
        ], 'What\'s Going on?',
            'The messages from NDI that you have intercepted have several layers of encryption, but you are determined to decrypt them. Time to do some more hacking...');
        break;

      case 3:
        level = LevelModel([
          getPuzzle4(),
          getPuzzle5(),
        ], 'Not on my watch!',
            'It seems like NDI are trying to replace their clean power plants with very pollutant ones. Wouldn\'t it be nice if you could hack those plants to render them unusable?');
        break;

      default:
    }

    Main.game = HackingDevice(level, () {
      Main.game = null;
      Audio.play(Song.MENU);
      Navigator.pop(context);
    }, () {
      switch (widget.level) {
        case 1:
          Main.game = null;
          Audio.play(Song.DRAMATIC);
          Navigator.of(context).pushReplacementNamed('/decrypt', arguments: 2);
          break;
        case 2:
          Main.game = null;
          Audio.play(Song.DRAMATIC);
          Navigator.of(context).pushReplacementNamed('/decrypt', arguments: 3);
          break;
        case 3:
          Main.game = null;
          Audio.play(Song.DRAMATIC);
          Navigator.of(context).pushReplacementNamed('/newspaper');
          break;
        default:
          Main.game = null;
          Audio.play(Song.MENU);
          Navigator.pop(context);
          break;
      }
      ;
    });
    Audio.play(Song.GAME);
    return Main.game.widget;
  }

  PuzzleModel getPuzzle1() {
    var validCellPositions = [
      [1, 2],
      [1, 3],
      [1, 4],
      [2, 2],
      [2, 3],
      [2, 4],
    ];
    var pieceModels = [
      PieceModel(
          isInOrOut: true,
          arithmeticValue: 3,
          positionInBoardRow: 2,
          positionInBoardColumn: 1),
      PieceModel(
          isInOrOut: true, positionInBoardRow: 1, positionInBoardColumn: 5),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(
          hastBottomCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastLeftCable: true,
          hastTopCable: true,
          positionInBoardRow: 2,
          positionInBoardColumn: 2),
    ];
    return PuzzleModel(validCellPositions, pieceModels, 8);
  }

  PuzzleModel getPuzzle2() {
    var validCellPositions = [
      [1, 1],
      [2, 1],
      [3, 1],
      [4, 1],
      [4, 2],
      [4, 3],
      [4, 4],
      [4, 5],
      [4, 6],
      [3, 6],
      [2, 6],
      [1, 6],
    ];
    var pieceModels = [
      PieceModel(
          isInOrOut: true,
          arithmeticValue: 1,
          positionInBoardRow: 0,
          positionInBoardColumn: 1),
      PieceModel(
          isInOrOut: true, positionInBoardRow: 0, positionInBoardColumn: 6),
      PieceModel(
          hastTopCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(
          hastTopCable: true,
          hastLeftCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          arithmeticValue: 3,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
    ];
    return PuzzleModel(validCellPositions, pieceModels, 1);
  }

  PuzzleModel getPuzzle3() {
    var validCellPositions = [
      [1, 2],
      [1, 3],
      [1, 4],
      [2, 2],
      [2, 3],
      [2, 4],
      [3, 2],
      [3, 3],
      [3, 4],
    ];
    var pieceModels = [
      PieceModel(
          isInOrOut: true,
          arithmeticValue: 8,
          positionInBoardRow: 1,
          positionInBoardColumn: 1),
      PieceModel(
          isInOrOut: true, positionInBoardRow: 3, positionInBoardColumn: 5),
      PieceModel(hastBottomCable: true, hastRightCable: true),
      PieceModel(
          hastBottomCable: true,
          hastLeftCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(
          hastTopCable: true,
          hastRightCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastTopCable: true,
          hastRightCable: true,
          arithmeticValue: 8,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastLeftCable: true, hastBottomCable: true),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          arithmeticValue: 3,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(hastLeftCable: true, hastTopCable: true),
    ];
    return PuzzleModel(validCellPositions, pieceModels, 9);
  }

  PuzzleModel getPuzzle4() {
    var validCellPositions = [
      [0, 3],
      [0, 4],
      [0, 5],
      [0, 6],
      [0, 7],
      [1, 3],
      [1, 4],
      [1, 5],
      [1, 6],
      [1, 7],
      [2, 3],
      [2, 7],
      [3, 3],
      [3, 4],
      [3, 5],
      [3, 6],
      [3, 7],
      [4, 3],
      [4, 4],
      [4, 5],
      [4, 6],
      [4, 7],
    ];
    var pieceModels = [
      PieceModel(
          isInOrOut: true,
          arithmeticValue: 6,
          positionInBoardRow: 0,
          positionInBoardColumn: 2),
      PieceModel(
          isInOrOut: true, positionInBoardRow: 4, positionInBoardColumn: 2),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          positionInBoardRow: 2,
          positionInBoardColumn: 4,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          positionInBoardRow: 2,
          positionInBoardColumn: 5,
          arithmeticValue: 3,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastTopCable: true,
          hastBottomCable: true,
          positionInBoardRow: 2,
          positionInBoardColumn: 6,
          arithmeticValue: 5,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(hastLeftCable: true, hastBottomCable: true),
      PieceModel(hastLeftCable: true, hastBottomCable: true),
      PieceModel(hastLeftCable: true, hastBottomCable: true),
      PieceModel(hastRightCable: true, hastBottomCable: true),
      PieceModel(hastRightCable: true, hastBottomCable: true),
      PieceModel(hastRightCable: true, hastTopCable: true),
      PieceModel(hastRightCable: true, hastTopCable: true),
      PieceModel(hastLeftCable: true, hastTopCable: true),
      PieceModel(hastLeftCable: true, hastTopCable: true),
      PieceModel(hastLeftCable: true, hastTopCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastTopCable: true, hastBottomCable: true),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(hastLeftCable: true, hastRightCable: true),
      PieceModel(hastLeftCable: true, hastRightCable: true),
    ];
    return PuzzleModel(validCellPositions, pieceModels, 9);
  }

  PuzzleModel getPuzzle5() {
    var validCellPositions = [
      [2, 2],
      [2, 3],
      [2, 4],
      [2, 5],
    ];
    var pieceModels = [
      PieceModel(
          isInOrOut: true,
          arithmeticValue: 5,
          positionInBoardRow: 2,
          positionInBoardColumn: 1),
      PieceModel(
          isInOrOut: true, positionInBoardRow: 2, positionInBoardColumn: 6),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 7,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 4,
          arithmeticOperation: ArithmeticOperation.subtract),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 3,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 1,
          arithmeticOperation: ArithmeticOperation.add),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 2,
          arithmeticOperation: ArithmeticOperation.multiply),
      PieceModel(
          hastLeftCable: true,
          hastRightCable: true,
          arithmeticValue: 5,
          arithmeticOperation: ArithmeticOperation.add),
    ];
    return PuzzleModel(validCellPositions, pieceModels, 5);
  }
}
