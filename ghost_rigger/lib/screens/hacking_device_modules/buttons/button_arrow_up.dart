import 'dart:ui';

import '../../hacking_device.dart';
import '../piece.dart';
import 'button_base.dart';

class ButtonArrowUp extends ButtonBase {
  ButtonArrowUp(HackingDevice hackingDevice, Function onPressed)
      : super(hackingDevice, 'button_arrow_up.png', 'button_arrow_up_pressed.png', onPressed);

  @override
  Rect getArea() {
    var width = hackingDevice.gameWidth * 0.111;
    var height = hackingDevice.gameHeight * 0.107;
    var offsetX = hackingDevice.gameWidth * 0.846;
    var offsetY = hackingDevice.gameHeight * 0.19;
    return Rect.fromLTWH(offsetX, offsetY, width, height);
  }

  @override
  void onTapDown(double dX, double dY) {
    super.onTapDown(dX, dY);
    if (pressed && Piece.draggedPiece == null)
      hackingDevice.pieceSelector.scrollDirection = 1;
  }

  @override
  void onTapUp(double dX, double dY) {
    super.onTapUp(dX, dY);
    hackingDevice.pieceSelector.scrollDirection = 0;
  }
}
