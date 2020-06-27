import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';

class Background {
  final HackingDevice hackingDevice;
  Sprite mainSprite;
  Sprite leftSprite;
  Sprite rightSprite;

  Background(this.hackingDevice) {
    mainSprite = Sprite('main.png');
    leftSprite = Sprite('left.png');
    rightSprite = Sprite('right.png');
  }

  void render(Canvas canvas) {
    mainSprite.renderRect(canvas, Rect.fromLTWH(0, 0, hackingDevice.gameWidth, hackingDevice.gameHeight));

    var leftWidth = hackingDevice.gameHeight * 0.363;
    leftSprite.renderRect(canvas, Rect.fromLTWH(1 - leftWidth, 0, leftWidth, hackingDevice.gameHeight));

    var rightWidth = hackingDevice.gameHeight * 0.383;
    leftSprite.renderRect(canvas, Rect.fromLTWH(hackingDevice.gameWidth - 1, 0, rightWidth, hackingDevice.gameHeight));
  }
}