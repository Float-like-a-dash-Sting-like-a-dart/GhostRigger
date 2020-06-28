import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:ghost_rigger/screens/hacking_device_modules/doors_animation.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/buttons/button_arrow_down.dart';
import 'hacking_device_modules/buttons/button_arrow_up.dart';
import 'hacking_device_modules/buttons/button_done.dart';
import 'hacking_device_modules/buttons/button_exit.dart';
import 'hacking_device_modules/buttons/button_info.dart';
import 'hacking_device_modules/buttons/button_next_step.dart';
import 'hacking_device_modules/buttons/button_restart.dart';
import 'hacking_device_modules/buttons/button_run.dart';
import 'hacking_device_modules/device_module_base.dart';
import 'hacking_device_modules/display_goal.dart';
import 'hacking_device_modules/display_output.dart';
import 'hacking_device_modules/light_animation.dart';
import 'hacking_device_modules/piece_selector.dart';
import 'hacking_device_modules/display_status.dart';
import 'hacking_device_modules/pieces/piece.dart';
import 'hacking_device_modules/pieces/piece_model.dart';

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
      ButtonArrowUp(this, null),
      ButtonArrowDown(this, null),
      ButtonExit(this, _onExit),
      DisplayGoal(this),
      DisplayOutput(this),
      LightAnimation(this),
      board,
      pieceSelector,
    ];

    // TODO This will have to be provided from somewhere to set up the puzzle
    var pieceModels = [
      PieceModel('line_number_bent.png'),
      PieceModel('line_horizontal.png'),
      PieceModel('line_number_bent.png'),
      PieceModel('line_number_horizontal.png'),
      PieceModel('line_number_bent.png'),
      PieceModel('line_horizontal.png'),
      PieceModel('line_bent.png'),
      PieceModel('line_number_horizontal.png'),
      PieceModel('line_number_bent.png', positionInBoardRow: 1, positionInBoardColumn: 3),
      PieceModel('line_bent.png', positionInBoardRow: 3, positionInBoardColumn: 4),
    ];

    // TODO This will have to be provided from somewhere to set up the puzzle
    var validPositions = [
      [1, 1], [1, 2], [1, 3], [1, 4],
      [2, 1], [2, 2], [2, 3], [2, 4],
      [3, 1], [3, 2], [3, 3], [3, 4],
    ];

    validPositions.forEach((validPosition) {
      board.validCells[validPosition[0]][validPosition[1]] = true;
    });

    var piecesForPieceSelector = pieceModels
        .where((piece) => piece.positionInBoardColumn == -1)
        .map((pieceModel) => Piece(this, pieceModel)).toList();
    piecesForPieceSelector.forEach((piece) {
      pieceSelector.pieces.add(piece);
      deviceModules.add(piece);
    });

    var piecesForBoard = pieceModels
        .where((pieceModel) => pieceModel.positionInBoardRow != -1)
        .map((pieceModel) => Piece(this, pieceModel)).toList();
    piecesForBoard.forEach((piece) {
      board.pieces[piece.positionInBoardRow][piece.positionInBoardColumn] = piece;
      deviceModules.add(piece);
    });

    deviceModules.add(DoorsAnimation(this));
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
    deviceModules.forEach((module) {
      module.update(t);
    });
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
