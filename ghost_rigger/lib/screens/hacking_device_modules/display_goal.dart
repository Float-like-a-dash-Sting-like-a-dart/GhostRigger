import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayGoal extends DeviceModuleBase {
  Sprite sprite;

  DisplayGoal(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_goal.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.187;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.441;
    var offsetY = hackingDevice.gameHeight * 0.038;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void onTapDown(double dX, double dY) {
    // Nothing to do here
  }

  @override
  void onTapUp(double dX, double dY) {
    // Nothing to do here
  }
}