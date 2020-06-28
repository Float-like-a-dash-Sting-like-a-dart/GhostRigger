import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'pieces/piece.dart';

class PieceSelector extends DeviceModuleBase {
  Sprite sprite;
  List<Piece> pieces;
  int scrollDirection;
  double scroll;
  double maxScrollValue;

  PieceSelector(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('module_selection_area.png');
    pieces = [];
    scrollDirection = 0;
    scroll = 0;
    maxScrollValue = 0;
  }

  void tryToAddPiece(Piece piece) {
    if (area.contains(piece.dragPosition) && !pieces.contains(piece)) {
      hackingDevice.board.pieces.forEach((boardPieces) {
        var pieceIndex = boardPieces.indexOf(piece);
        if (pieceIndex != -1)
          boardPieces[pieceIndex] = null;
      });
      pieces.remove(piece);
      pieces.add(piece);
      piece.isInPieceSelector = true;
      piece.positionInBoardRow = -1;
      piece.positionInBoardColumn = -1;
    }
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.111;
    var height = hackingDevice.gameHeight * 0.558;
    var offsetX = hackingDevice.gameWidth * 0.846;
    var offsetY = hackingDevice.gameHeight * 0.296;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);

    var pieceIndex = 0;
    var spacingBetweenPieces = hackingDevice.board.cellSize * 0.075;
    var pieceOffsetX = offsetX + ((width - hackingDevice.board.cellSize) / 2);
    pieces.toList().forEach((piece) {
      var pieceOffsetY = offsetY +
          (pieceIndex * hackingDevice.board.cellSize) +
          (spacingBetweenPieces * (pieceIndex + 1));
      piece.offset = Offset(pieceOffsetX, pieceOffsetY + scroll);
      piece.boundaries = area;
      maxScrollValue = pieceOffsetY - offsetY - height + hackingDevice.board.cellSize + spacingBetweenPieces;
      pieceIndex++;
    });
  }

  @override
  void update(double t) {
    if (scrollDirection != 0) {
      var newScroll = scroll + scrollDirection * t * 500;
      if (_isScrollValid(newScroll))
        scroll = newScroll;
    }

    if (!_isScrollValid(scroll)) {
      // Restart scroll when the number of pieces has changed
      var distanceToZero = (0 - scroll).abs();
      var distanceToMax = (maxScrollValue - scroll).abs();
      if (distanceToZero > distanceToMax || maxScrollValue <= 0)
        scroll = 0;
      else
        scroll = -maxScrollValue;
    }
  }

  bool _isScrollValid(double newScroll) {
    return maxScrollValue > 0 && newScroll <= 0 && newScroll >= -maxScrollValue;
  }
}