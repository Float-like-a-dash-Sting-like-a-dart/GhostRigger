import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'piece.dart';

class Board extends DeviceModuleBase {
  Sprite boardBackgroundSprite;
  Sprite blockedCellSprite;
  List<List<Piece>> pieces;
  List<List<bool>> validCells;
  double cellSize;

  Board(HackingDevice hackingDevice) : super(hackingDevice) {
    boardBackgroundSprite = Sprite('board.png');
    blockedCellSprite = Sprite('blocked_cell.png');
    pieces = List.generate(5, (i) => List.generate(8, (j) => null, growable: false), growable: false);
    validCells = List.generate(5, (i) => List.generate(8, (j) => false, growable: false), growable: false);
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.683;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.143;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    boardBackgroundSprite.renderRect(canvas, area);

    var widthUsableArea = hackingDevice.gameWidth * 0.647;
    cellSize = widthUsableArea / 8;
    var offsetUsableAreaX = area.left + (hackingDevice.gameWidth * 0.016);
    var offsetUsableAreaY = area.top + (hackingDevice.gameHeight * 0.028);
      for (int i = 0; i < 5; i++)
        for (int j = 0; j < 8; j++) {
          if (!validCells[i][j]) {
            var cellArea = Rect.fromLTWH(offsetUsableAreaX + (j * cellSize), offsetUsableAreaY + (i * cellSize), cellSize, cellSize);
            blockedCellSprite.renderRect(canvas, cellArea);
          }
        }

    pieces.toList().forEach((piecesRow) {
      piecesRow.toList().where((piece) => piece != null).forEach((piece) {
        _setBoardPieceOffset(piece);
      });
    });
  }

  void _setBoardPieceOffset(Piece piece) {
    var width = hackingDevice.gameWidth * 0.647;
    var offsetX = area.left + (hackingDevice.gameWidth * 0.016);
    var offsetY = area.top + (hackingDevice.gameHeight * 0.028);
    cellSize = width / 8;
    var cellArea = Rect.fromLTWH(offsetX + (piece.positionInBoardColumn * cellSize), offsetY + (piece.positionInBoardRow * cellSize), cellSize, cellSize);
    piece.offset = Offset(cellArea.left, cellArea.top);
  }

  void tryToAddPiece(Piece piece, Offset dragPosition) {
    var width = hackingDevice.gameWidth * 0.647;
    var height = hackingDevice.gameHeight * 0.71;
    var offsetX = area.left + (hackingDevice.gameWidth * 0.016);
    var offsetY = area.top + (hackingDevice.gameHeight * 0.028);
    var usableArea = Rect.fromLTWH(offsetX, offsetY, width, height);
    if (usableArea.contains(dragPosition)) {
      cellSize = width / 8;
      for (int i = 0; i < 5; i++)
        for (int j = 0; j < 8; j++) {
          var cellArea = Rect.fromLTWH(offsetX + (j * cellSize), offsetY + (i * cellSize), cellSize, cellSize);
          if (cellArea.contains(dragPosition) && validCells[i][j] && (pieces[i][j] == null || pieces[i][j] == piece || piece.positionInBoardRow != -1)) {
            hackingDevice.pieceSelector.pieces.remove(piece);
            pieces.forEach((boardPieces) {
              var pieceIndex = boardPieces.indexOf(piece);
              if (pieceIndex != -1) {
                if (pieces[i][j] != null && pieces[i][j] != piece) {
                  boardPieces[pieceIndex] = pieces[i][j];
                  boardPieces[pieceIndex].positionInBoardRow = piece.positionInBoardRow;
                  boardPieces[pieceIndex].positionInBoardColumn = piece.positionInBoardColumn;
                } else
                 boardPieces[pieceIndex] = null;
              }
            });
            pieces[i][j] = piece;
            piece.isInPieceSelector = false;
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