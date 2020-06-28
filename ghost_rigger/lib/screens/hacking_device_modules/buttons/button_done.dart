import 'dart:ui';

import '../../hacking_device.dart';
import 'button_base.dart';

class ButtonDone extends ButtonBase {
  ButtonDone(HackingDevice hackingDevice, Function onPressed)
      : super(hackingDevice, 'button_done.png', 'button_done_pressed.png', onPressed);

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.102;
    var offsetX = hackingDevice.gameWidth * 0.043;
    var offsetY = hackingDevice.gameHeight * 0.483;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }
}
