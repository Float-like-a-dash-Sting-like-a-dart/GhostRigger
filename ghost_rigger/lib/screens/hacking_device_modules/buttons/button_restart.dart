import 'dart:ui';

import '../../hacking_device.dart';
import 'button_base.dart';

class ButtonRestart extends ButtonBase {
  ButtonRestart(HackingDevice hackingDevice, Function onPressed)
      : super(hackingDevice, 'button_restart.png', 'button_restart_pressed.png', onPressed);

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.340;
    var offsetY = hackingDevice.gameHeight * 0.038;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }

  @override
  void update(double t) {
    enabled = !hackingDevice.isShowingInfo && hackingDevice.puzzle.simulationRunning;
  }

  @override
  void onPressed() {
    hackingDevice.clearPuzzleSolution();
  }
}
