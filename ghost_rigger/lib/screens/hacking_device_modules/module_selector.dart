import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class ModuleSelector extends DeviceModuleBase {
  Sprite moduleSelectionSprite;

  ModuleSelector(HackingDevice hackingDevice) : super(hackingDevice) {
    moduleSelectionSprite = Sprite('module_selection_area.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.111;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.846;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    moduleSelectionSprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void onTapDown(double dX, double dY) {
    // Nothing to do here
  }

  @override
  void onTapUp(double dX, double dY) {
    // Nothing to do here
  }
}