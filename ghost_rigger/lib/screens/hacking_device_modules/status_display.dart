import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class StatusDisplay extends DeviceModuleBase {
  Sprite statusDisplaySprite;

  StatusDisplay(HackingDevice hackingDevice) : super(hackingDevice) {
    statusDisplaySprite = Sprite('display_steps_and_status.png');
  }

  @override
  void render(Canvas canvas) {
    var boardWidth = hackingDevice.gameWidth * 0.089;
    var boardHeight = hackingDevice.gameHeight * 0.274;
    var boardOffsetX = hackingDevice.gameWidth * 0.043;
    var boardOffsetY = hackingDevice.gameHeight * 0.19;
    statusDisplaySprite.renderRect(canvas, Rect.fromLTWH(boardOffsetX, boardOffsetY, boardWidth, boardHeight));
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}