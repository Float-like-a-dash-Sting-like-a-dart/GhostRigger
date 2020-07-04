import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class Background extends DeviceModuleBase {
  Sprite mainSprite;
  Sprite leftSprite;
  Sprite rightSprite;

  Background(HackingDevice hackingDevice) : super(hackingDevice) {
    mainSprite = Sprite('main.png');
    leftSprite = Sprite('left.png');
    rightSprite = Sprite('right.png');
  }

  @override
  void render(Canvas canvas) {
    mainSprite.renderRect(canvas, Rect.fromLTWH(0, 0, hackingDevice.gameWidth, hackingDevice.gameHeight));

    var leftWidth = hackingDevice.gameHeight * 0.363;
    leftSprite.renderRect(canvas, Rect.fromLTWH(1 - leftWidth, 0, leftWidth, hackingDevice.gameHeight));

    var rightWidth = hackingDevice.gameHeight * 0.383;
    rightSprite.renderRect(canvas, Rect.fromLTWH(hackingDevice.gameWidth - 1, 0, rightWidth, hackingDevice.gameHeight));
  }

  @override
  void update(double t) {
    // Nothing to update here
  }
}