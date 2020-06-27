import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayStatus extends DeviceModuleBase {
  Sprite sprite;

  DisplayStatus(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_steps_and_status.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.274;
    var offsetX = hackingDevice.gameWidth * 0.043;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}