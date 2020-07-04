import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DoorsAnimation extends DeviceModuleBase {
  Sprite leftDoorSprite;
  Sprite rightDoorSprite;
  double offsetLeftDoor = 0;
  double offsetRightDoor = 0;
  bool renderLeft = true;
  bool renderRight = true;

  DoorsAnimation(HackingDevice hackingDevice) : super(hackingDevice) {
    leftDoorSprite = Sprite('left_door.png');
    rightDoorSprite = Sprite('right_door.png');
  }

  @override
  void render(Canvas canvas) {
    if (renderRight) {
      var rightDoorWidth = hackingDevice.screenSize.height * 1.255;
      var rightDoorOffsetX = 0.503 * hackingDevice.gameWidth + offsetRightDoor;
      var rightDoorRect = Rect.fromLTWH(
          rightDoorOffsetX, 0, rightDoorWidth, hackingDevice.screenSize.height);
      rightDoorSprite.renderRect(canvas, rightDoorRect);
    }

    if (renderLeft) {
      var leftDoorWidth = hackingDevice.gameHeight * 1.278;
      var leftDoorOffsetX = 0.522 * hackingDevice.gameWidth - leftDoorWidth +
          offsetLeftDoor;
      var leftDoorRect = Rect.fromLTWH(
          leftDoorOffsetX, 0, leftDoorWidth, hackingDevice.gameHeight);
      leftDoorSprite.renderRect(canvas, leftDoorRect);
    }
  }

  @override
  void update(double t) {
    if (renderLeft) {
      offsetLeftDoor -= t * 600;
      var minOffsetLeftDoor = -((hackingDevice.gameWidth ?? 0) * 0.488);
      if (offsetLeftDoor < minOffsetLeftDoor) {
        offsetLeftDoor = minOffsetLeftDoor;
        renderLeft = false;
      }
    }

    if (renderRight) {
      offsetRightDoor += t * 600;
      var maxOffsetLeftDoor = (hackingDevice.gameWidth ?? 0) * 0.471;
      if (offsetRightDoor > maxOffsetLeftDoor) {
        offsetRightDoor = maxOffsetLeftDoor;
        renderRight = false;
      }
    }
  }
}