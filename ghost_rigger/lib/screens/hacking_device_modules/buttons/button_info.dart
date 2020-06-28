import 'dart:ui';

import '../../hacking_device.dart';
import 'button_base.dart';

class ButtonInfo extends ButtonBase {
  ButtonInfo(HackingDevice hackingDevice, Function onPressed)
      : super(hackingDevice, 'button_info.png', 'button_info_pressed.png', onPressed);

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.043;
    var offsetY = hackingDevice.gameHeight * 0.038;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }

  @override
  void update(double t) {
    enabled = !hackingDevice.isShowingInfo;
  }

  @override
  void onPressed() {
    hackingDevice.showInfo();
  }
}
