import 'dart:ui';
import 'package:flame/sprite.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'pieces/piece_base.dart';

class Board extends DeviceModuleBase {
  Sprite sprite;
  List<List<PieceBase>> boardPieces;

  Board(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('board.png');
    boardPieces = List.generate(5, (i) => List.generate(8, (j) => null));
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.683;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.143;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
  }

  bool tryToAddPiece(PieceBase pieceBase) {
    var width = hackingDevice.gameWidth * 0.647;
    var height = hackingDevice.gameHeight * 0.71;
    var offsetX = area.left + (hackingDevice.gameWidth * 0.017);
    var offsetY = area.top + (hackingDevice.gameHeight * 0.028);
    var usableArea = Rect.fromLTWH(offsetX, offsetY, width, height);
    if (usableArea.contains(pieceBase.dragPosition)) {
      var cellSize = width / 8;
      for (int i = 0; i <= 5; i++)
        for (int j = 0; j <= 8; j++) {
          var cellArea = Rect.fromLTWH(offsetX + (j * cellSize), offsetY + (i * cellSize), cellSize, cellSize);
          if (cellArea.contains(pieceBase.dragPosition) && (boardPieces[i][j] == null || boardPieces[i][j] == pieceBase)) {
            boardPieces[i][j] = pieceBase;
            pieceBase.dragPosition = cellArea.center;
            return true;
          }
        }
    }

    return false;
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}