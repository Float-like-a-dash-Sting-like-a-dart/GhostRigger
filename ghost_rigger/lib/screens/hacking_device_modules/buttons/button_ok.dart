import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../../hacking_device.dart';
import 'button_base.dart';

class ButtonOK extends ButtonBase {
  ButtonOK(HackingDevice hackingDevice, Function onPressed)
      : super(hackingDevice, 'button_ok.png', 'button_ok_pressed.png', onPressed);

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.25;
    var height = hackingDevice.gameWidth * 0.062;
    var offsetX = hackingDevice.gameWidth * 0.363;
    var offsetY = hackingDevice.gameHeight * 0.783;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }

  @override
  void setAlphaFromStatus() {
    paint.color = Color.fromRGBO(0, 0, 0, enabled ? 1.0 : 0.0);
  }

  @override
  void update(double t) {
    enabled = hackingDevice.isShowingInfo;
  }

  @override
  void onPressed() {
    hackingDevice.hideInfo();
  }
}
