import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/button_done.dart';
import 'hacking_device_modules/button_exit.dart';
import 'hacking_device_modules/button_info.dart';
import 'hacking_device_modules/button_next_step.dart';
import 'hacking_device_modules/button_restart.dart';
import 'hacking_device_modules/button_run.dart';
import 'hacking_device_modules/device_module_base.dart';
import 'hacking_device_modules/display_goal.dart';
import 'hacking_device_modules/display_output.dart';
import 'hacking_device_modules/piece_selector.dart';
import 'hacking_device_modules/display_status.dart';

class HackingDevice extends Game
    with MultiTouchTapDetector, MultiTouchDragDetector {
  Size screenSize;
  double gameHeight;
  double gameWidth;
  Board board;
  PieceSelector pieceSelector;

  List<DeviceModuleBase> deviceModules;

  void Function() _onExit;

  HackingDevice(this._onExit) {
    board = Board(this);
    pieceSelector = PieceSelector(this);
    deviceModules = [
      Background(this),
      DisplayStatus(this),
      ButtonInfo(this, null),
      ButtonRun(this, null),
      ButtonNextStep(this, null),
      ButtonRestart(this, null),
      ButtonDone(this, null),
      ButtonExit(this, _onExit),
      DisplayGoal(this),
      DisplayOutput(this),
      board,
      pieceSelector,
    ];
  }

  @override
  void render(Canvas canvas) {
    preRender(canvas);
    deviceModules.forEach((module) {
      module.render(canvas);
    });
    postRender(canvas);
  }

  void preRender(Canvas canvas) {
    gameHeight = screenSize.height;
    gameWidth = gameHeight * 1.753;
    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    canvas.save();
    canvas.translate(mainOffsetX, 0);
  }

  void postRender(Canvas canvas) {
    canvas.restore();
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void onTapUp(int pointerId, TapUpDetails details) {
    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onTapUp(tapCorrectedX, tapCorrectedY);
    });
  }

  @override
  void onTapDown(int pointerId, TapDownDetails details) {
    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onTapDown(tapCorrectedX, tapCorrectedY);
    });
  }

  @override
  void onTap(int pointerId) {
    deviceModules.forEach((module) {
      module.onTap();
    });
  }

  @override
  void onTapCancel(int pointerId) {
    deviceModules.forEach((module) {
      module.onTapCancel();
    });
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    drag.onUpdate = _onDragUpdated;
    drag.onEnd = _onDragEnded;
    drag.onCancel = _onDragCancelled;
  }

  void _onDragUpdated(DragUpdateDetails details) {
    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onDragUpdate(tapCorrectedX, tapCorrectedY);
    });
  }

  void _onDragEnded(DragEndDetails details) {
    deviceModules.forEach((module) {
      module.onDragEnd(details.velocity);
    });
  }

  void _onDragCancelled() {
    deviceModules.forEach((module) {
      module.onDragCancel();
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
