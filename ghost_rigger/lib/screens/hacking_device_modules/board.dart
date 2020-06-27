import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class Board extends DeviceModuleBase {
  Sprite sprite;

  Board(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('board.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.683;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.143;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}