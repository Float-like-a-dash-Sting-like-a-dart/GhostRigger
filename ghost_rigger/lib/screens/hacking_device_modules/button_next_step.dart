import 'dart:ui';

import '../hacking_device.dart';
import 'device_button_base.dart';

class ButtonNextStep extends DeviceButtonBase {

  ButtonNextStep(HackingDevice hackingDevice)
      : super(hackingDevice, 'button_next_step.png', 'button_next_step_pressed.png');

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.240;
    var offsetY = hackingDevice.gameHeight * 0.038;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }
}