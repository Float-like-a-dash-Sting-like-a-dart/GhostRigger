import 'dart:ui';
import 'package:flame/sprite.dart';

import '../../hacking_device.dart';
import '../device_module_base.dart';

abstract class ButtonBase extends DeviceModuleBase {
  Sprite buttonSprite;
  Sprite buttonPressedSprite;
  Paint paint;
  bool pressed;
  bool enabled;

  void Function() _onPressed;

  ButtonBase(HackingDevice hackingDevice, String buttonSpriteName,
      String buttonPressedSpriteName, this._onPressed)
      : super(hackingDevice) {
    buttonSprite = Sprite(buttonSpriteName);
    buttonPressedSprite = Sprite(buttonPressedSpriteName);
    paint = Paint();
    enabled = true;
    pressed = false;
  }

  @override
  void render(Canvas canvas) {
    setAlphaFromStatus();
    area = getArea();
    if (pressed)
      buttonPressedSprite.renderRect(canvas, area, overridePaint: paint);
    else
      buttonSprite.renderRect(canvas, area, overridePaint: paint);
  }

  void setAlphaFromStatus() {
    if (enabled)
      paint.color = Color.fromRGBO(0, 0, 0, 1.0);
    else
      paint.color = Color.fromRGBO(0, 0, 0, 0.3);
  }

  Rect getArea();

  @override
  void update(double t) {
    // Nothing to do here
  }

  @override
  void onTapDown(double dX, double dY) {
    pressed = area.contains(Offset(dX, dY));
  }

  @override
  void onTapUp(double dX, double dY) {
    pressed = false;
    if (area.contains(Offset(dX, dY))) {
      onPressed();
      _onPressed?.call();
    }
  }

  @override
  void onTapCancel() {
    pressed = false;
  }

  void onPressed() {}
}

