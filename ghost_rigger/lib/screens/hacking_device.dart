import 'dart:ui';

import 'package:flame/game.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/module_selector.dart';
import 'hacking_device_modules/status_display.dart';

class HackingDevice extends Game {
  Size screenSize;
  double gameHeight;
  double gameWidth;

  Background background;
  Board board;
  ModuleSelector moduleSelector;
  StatusDisplay statusDisplay;

  HackingDevice() {
    background = Background(this);
    board = Board(this);
    moduleSelector = ModuleSelector(this);
    statusDisplay = StatusDisplay(this);
  }

  void render(Canvas canvas) {
    preRender(canvas);

    background.render(canvas);
    board.render(canvas);
    moduleSelector.render(canvas);
    statusDisplay.render(canvas);

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

  void update(double t) {
    // TODO: implement update
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}