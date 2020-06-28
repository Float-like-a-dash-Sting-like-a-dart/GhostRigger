import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'pieces/piece.dart';

class Board extends DeviceModuleBase {
  Sprite sprite;
  List<List<Piece>> pieces;

  Board(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('board.png');
    pieces = List.generate(5, (i) => List.generate(8, (j) => null));
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.683;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.143;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    pieces.toList().forEach((piecesRow) {
      piecesRow.toList().where((piece) => piece != null).forEach((piece) {
        _setBoardPieceOffset(piece);
      });
    });
  }

  void _setBoardPieceOffset(Piece piece) {
    var width = hackingDevice.gameWidth * 0.647;
    var height = hackingDevice.gameHeight * 0.71;
    var offsetX = area.left + (hackingDevice.gameWidth * 0.017);
    var offsetY = area.top + (hackingDevice.gameHeight * 0.028);
    var cellSize = width / 8;
    var cellArea = Rect.fromLTWH(offsetX + (piece.positionInBoardColumn * cellSize), offsetY + (piece.positionInBoardRow * cellSize), cellSize, cellSize);
    piece.offset = Offset(cellArea.left, cellArea.top);
  }

  void tryToAddPiece(Piece piece) {
    var width = hackingDevice.gameWidth * 0.647;
    var height = hackingDevice.gameHeight * 0.71;
    var offsetX = area.left + (hackingDevice.gameWidth * 0.017);
    var offsetY = area.top + (hackingDevice.gameHeight * 0.028);
    var usableArea = Rect.fromLTWH(offsetX, offsetY, width, height);
    if (usableArea.contains(piece.dragPosition)) {
      var cellSize = width / 8;
      for (int i = 0; i < 5; i++)
        for (int j = 0; j < 8; j++) {
          var cellArea = Rect.fromLTWH(offsetX + (j * cellSize), offsetY + (i * cellSize), cellSize, cellSize);
          if (cellArea.contains(piece.dragPosition) && (pieces[i][j] == null || pieces[i][j] == piece)) {
            hackingDevice.pieceSelector.pieces.remove(piece);
            pieces[i][j] = piece;
            piece.positionInBoardRow = i;
            piece.positionInBoardColumn = j;
            return;
          }
        }
    }
  }

  @override
  void update(double t) {
    // Nothing to do here
  }
}