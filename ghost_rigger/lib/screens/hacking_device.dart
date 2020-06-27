import 'dart:ui';

import 'package:flame/game.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/device_module_base.dart';
import 'hacking_device_modules/module_selector.dart';
import 'hacking_device_modules/status_display.dart';

class HackingDevice extends Game {
  Size screenSize;
  double gameHeight;
  double gameWidth;

  List<DeviceModuleBase> deviceModules;

  HackingDevice() {
    deviceModules = [
      Background(this),
      Board(this),
      ModuleSelector(this),
      StatusDisplay(this),
    ];
  }

  @override
  void render(Canvas canvas) {
    preRender(canvas);
    deviceModules.forEach((module) { module.render(canvas); });
    postRender(canvas);
  }

  void preRender(Canvas canvas) {
    gameHeight = screenSize.width;
    gameWidth = gameHeight * 1.753;
    var mainOffsetX = (screenSize.height - gameWidth) / 2;
    canvas.save();
    canvas.rotate(1.5708);
    canvas.translate(mainOffsetX, -screenSize.width);
  }

  void postRender(Canvas canvas) {
    canvas.restore();
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}