import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';

class ModuleSelector {
  final HackingDevice hackingDevice;
  Sprite moduleSelectionSprite;

  ModuleSelector(this.hackingDevice) {
    moduleSelectionSprite = Sprite('module_selection_area.png');
  }

  void render(Canvas canvas) {
    var boardWidth = hackingDevice.gameWidth * 0.111;
    var boardHeight = hackingDevice.gameHeight * 0.768;
    var boardOffsetX = hackingDevice.gameWidth * 0.846;
    var boardOffsetY = hackingDevice.gameHeight * 0.19;
    moduleSelectionSprite.renderRect(canvas, Rect.fromLTWH(boardOffsetX, boardOffsetY, boardWidth, boardHeight));
  }
}