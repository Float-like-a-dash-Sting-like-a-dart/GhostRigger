import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class Board extends DeviceModuleBase {
  Sprite boardSprite;

  Board(HackingDevice hackingDevice) : super(hackingDevice) {
    boardSprite = Sprite('board.png');
  }

  @override
  void render(Canvas canvas) {
    var boardWidth = hackingDevice.gameWidth * 0.683;
    var boardHeight = hackingDevice.gameHeight * 0.768;
    var boardOffsetX = hackingDevice.gameWidth * 0.143;
    var boardOffsetY = hackingDevice.gameHeight * 0.19;
    boardSprite.renderRect(canvas, Rect.fromLTWH(boardOffsetX, boardOffsetY, boardWidth, boardHeight));
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}