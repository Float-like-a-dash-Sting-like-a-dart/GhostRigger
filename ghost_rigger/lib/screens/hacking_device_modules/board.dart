import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';

class Board {
  final HackingDevice hackingDevice;
  Sprite boardSprite;

  Board(this.hackingDevice) {
    boardSprite = Sprite('board.png');
  }

  void render(Canvas canvas) {
    var boardWidth = hackingDevice.gameWidth * 0.683;
    var boardHeight = hackingDevice.gameHeight * 0.768;
    var boardOffsetX = hackingDevice.gameWidth * 0.143;
    var boardOffsetY = hackingDevice.gameHeight * 0.19;
    boardSprite.renderRect(canvas, Rect.fromLTWH(boardOffsetX, boardOffsetY, boardWidth, boardHeight));
  }
}