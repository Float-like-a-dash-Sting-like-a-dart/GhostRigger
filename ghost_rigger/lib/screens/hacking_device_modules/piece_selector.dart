import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'piece.dart';

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

  void tryToAddPiece(Piece piece, Offset dragPosition) {
    if (area.contains(dragPosition) && !pieces.contains(piece)) {
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
      maxScrollValue = pieceOffsetY - offsetY - height + hackingDevice.board.cellSize + spacingBetweenPieces;
      pieceIndex++;
    });
  }

  @override
  void update(double t) {
    var newScroll = scrollDirection != 0 ? (scroll + scrollDirection * t * 500) : null;
    if (newScroll != null) {
      var isNewScrollValid = maxScrollValue > 0 && newScroll <= 0 && newScroll >= -maxScrollValue;
      if (!isNewScrollValid)
        correctScroll(newScroll);
      else
        scroll = newScroll;
    }

    // We still have to check because we might need to correct the scroll after a piece has been removed
    var isScrollValid = maxScrollValue > 0 && scroll <= 0 && scroll >= -maxScrollValue;
    if (!isScrollValid)
      correctScroll(scroll);
  }

  void correctScroll(double newScroll) {
    var distanceToZero = newScroll.abs();
    var distanceToMax = (-maxScrollValue - newScroll).abs();
    if (distanceToZero < distanceToMax || maxScrollValue <= 0)
      scroll = 0;
    else
      scroll = -maxScrollValue;
  }
}