import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayOutput extends DeviceModuleBase {
  Sprite sprite;

  DisplayOutput(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_output.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.187;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.639;
    var offsetY = hackingDevice.gameHeight * 0.038;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}