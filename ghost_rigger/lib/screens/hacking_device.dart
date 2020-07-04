import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:ghost_rigger/screens/hacking_device_modules/buttons/button_skip_level.dart';
import 'package:ghost_rigger/screens/hacking_device_modules/doors_animation.dart';

import 'hacking_device_modules/background.dart';
import 'hacking_device_modules/board.dart';
import 'hacking_device_modules/buttons/button_arrow_down.dart';
import 'hacking_device_modules/buttons/button_arrow_up.dart';
import 'hacking_device_modules/buttons/button_done.dart';
import 'hacking_device_modules/buttons/button_exit.dart';
import 'hacking_device_modules/buttons/button_info.dart';
import 'hacking_device_modules/buttons/button_next_step.dart';
import 'hacking_device_modules/buttons/button_ok.dart';
import 'hacking_device_modules/buttons/button_restart.dart';
import 'hacking_device_modules/buttons/button_run.dart';
import 'hacking_device_modules/device_module_base.dart';
import 'hacking_device_modules/display_goal.dart';
import 'hacking_device_modules/display_output.dart';
import 'hacking_device_modules/info.dart';
import 'hacking_device_modules/light_animation.dart';
import 'hacking_device_modules/piece_selector.dart';
import 'hacking_device_modules/display_status.dart';
import 'hacking_device_modules/piece.dart';
import 'models/level_model.dart';
import 'models/piece_model.dart';
import 'models/puzzle_model.dart';

class HackingDevice extends Game
    with MultiTouchTapDetector, MultiTouchDragDetector {

  Size screenSize;
  double gameHeight;
  double gameWidth;
  Board board;
  PieceSelector pieceSelector;
  Info info;
  List<DeviceModuleBase> deviceModules;

  LevelModel level;
  PuzzleModel puzzle;
  int puzzleNumber;
  int numberOfPuzzles;
  bool isShowingInfo;

  void Function() _onExit;
  void Function() _onCompleted;

  HackingDevice(this.level, this._onExit, this._onCompleted) {
    puzzleNumber = 0;
    numberOfPuzzles = level.puzzles.length;
    setUpNextPuzzle();
  }

  bool setUpNextPuzzle() {
    if (level.puzzles.isEmpty) {
      _onCompleted.call();
      return true;
    }

    puzzleNumber++;

    puzzle = level.puzzles.first;
    level.puzzles.remove(puzzle);
    puzzle.clearSolution();

    board = Board(this);
    pieceSelector = PieceSelector(this);
    info = Info(this);
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

    puzzle.validCellPositions.forEach((validPosition) {
      board.validCells[validPosition[0]][validPosition[1]] = true;
    });

    var piecesForPieceSelector = puzzle.pieces
        .where((piece) => piece.positionInBoardColumn == -1)
        .map((pieceModel) => Piece(this, pieceModel)).toList();
    piecesForPieceSelector.forEach((piece) {
      pieceSelector.pieces.add(piece);
      piece.isInPieceSelector = true;
      deviceModules.add(piece);
    });

    var piecesForBoard = puzzle.pieces
        .where((pieceModel) => pieceModel.positionInBoardRow != -1)
        .map((pieceModel) => Piece(this, pieceModel)).toList();
    piecesForBoard.forEach((piece) {
      board.pieces[piece.positionInBoardRow][piece.positionInBoardColumn] = piece;
      piece.isInPieceSelector = false;
      deviceModules.add(piece);
    });

    deviceModules.add(info);
    deviceModules.add(ButtonOK(this, null));
    deviceModules.add(ButtonSkipLevel(this, null));

    if (puzzleNumber == 1) {
      showInfo();
      deviceModules.add(DoorsAnimation(this));
    } else
      hideInfo();

    return false;
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
    print('onTapUp: ${details.globalPosition}');

    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onTapUp(tapCorrectedX, tapCorrectedY);
    });
  }

  @override
  void onTapDown(int pointerId, TapDownDetails details) {
    print('onTapDown: ${details.globalPosition}');

    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onTapDown(tapCorrectedX, tapCorrectedY);
    });
  }

  @override
  void onTap(int pointerId) {
    print('onTap');

    deviceModules.forEach((module) {
      module.onTap();
    });
  }

  @override
  void onTapCancel(int pointerId) {
    print('onTapCancel');

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
    print('_onDragUpdated: ${details.globalPosition}');

    var mainOffsetX = (screenSize.width - gameWidth) / 2;
    var tapCorrectedX = details.globalPosition.dx - mainOffsetX;
    var tapCorrectedY = details.globalPosition.dy;
    deviceModules.forEach((module) {
      module.onDragUpdate(tapCorrectedX, tapCorrectedY);
    });
  }

  void _onDragEnded(DragEndDetails details) {
    print('_onDragEnded: ${details.velocity}');

    deviceModules.forEach((module) {
      module.onDragEnd(details.velocity);
    });
  }

  void _onDragCancelled() {
    print('_onDragCancelled');

    deviceModules.forEach((module) {
      module.onDragCancel();
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void clearPuzzleSolution() {
    puzzle.clearSolution();
    board.pieces.forEach((piecesRow) { piecesRow.forEach((piece) { piece?.isLit = false; }); });
  }

  void solvePuzzle() {
    var pieceModelRows = board.pieces.map((piecesRow) => piecesRow.map((piece) => _fromPieceToPieceModel(piece)).toList());
    puzzle.solvePuzzle(pieceModelRows.toList());
    puzzle.visitedPieces.forEach((visitedPiece) {
      board.pieces[visitedPiece.positionInBoardRow][visitedPiece.positionInBoardColumn].isLit = true;
    });
  }

  void solveNextStep() {
    var pieceModelRows = board.pieces.map((piecesRow) => piecesRow.map((piece) => _fromPieceToPieceModel(piece)).toList());
    puzzle.solveNextStep(pieceModelRows.toList());
    puzzle.visitedPieces.forEach((visitedPiece) {
      board.pieces[visitedPiece.positionInBoardRow][visitedPiece.positionInBoardColumn].isLit = true;
    });
  }

  void showInfo() {
    isShowingInfo = true;
    info.title = level.infoTitle;
    info.text = level.infoDescription;
    info.show = true;
  }

  void hideInfo() {
    isShowingInfo = false;
    info.show = false;
  }

  PieceModel _fromPieceToPieceModel(Piece piece) {
    return piece != null
        ? PieceModel(
        positionInBoardColumn: piece.positionInBoardColumn,
        positionInBoardRow: piece.positionInBoardRow,
        arithmeticValue: piece.arithmeticValue,
        arithmeticOperation: piece.arithmeticOperation,
        hastTopCable: piece.hastTopCable,
        hastRightCable: piece.hastRightCable,
        hastBottomCable: piece.hastBottomCable,
        hastLeftCable: piece.hastLeftCable,
        isInOrOut: piece.isInOrOut)
        : null;
  }
}
