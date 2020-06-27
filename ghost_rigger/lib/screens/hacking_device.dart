import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/button_info.dart';
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
      ButtonInfo(this),
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

  void onTapDown(TapDownDetails tapDownDetails) {
    var mainOffsetX = (screenSize.height - gameWidth) / 2;
    var tapCorrectedX = tapDownDetails.globalPosition.dy - mainOffsetX;
    var tapCorrectedY = screenSize.width - tapDownDetails.globalPosition.dx;
    deviceModules.forEach((module) { module.onTapDown(tapCorrectedX, tapCorrectedY); });
  }

  void onTapUp(TapUpDetails tapUpDetails) {
    var mainOffsetX = (screenSize.height - gameWidth) / 2;
    var tapCorrectedX = tapUpDetails.globalPosition.dy - mainOffsetX;
    var tapCorrectedY = screenSize.width - tapUpDetails.globalPosition.dx;
    deviceModules.forEach((module) { module.onTapUp(tapCorrectedX, tapCorrectedY); });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}