import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'pieces/piece.dart';

class PieceSelector extends DeviceModuleBase {
  Sprite sprite;
  List<Piece> pieces;

  PieceSelector(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('module_selection_area.png');
    pieces = [];
  }

  void tryToAddPiece(Piece piece) {
    if (area.contains(piece.dragPosition) && !pieces.contains(piece)) {
      hackingDevice.board.pieces.forEach((boardPieces) { boardPieces.remove(piece); });
      pieces.add(piece);
      piece.positionInBoardRow = -1;
      piece.positionInBoardColumn = -1;
    }
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.111;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.846;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    pieces.toList().forEach((piece) {
      piece.offset = Offset(hackingDevice.gameWidth * 0.846, hackingDevice.gameHeight * 0.19);
    });
  }

  @override
  void update(double t) {
    // Nothing to do here
  }
}