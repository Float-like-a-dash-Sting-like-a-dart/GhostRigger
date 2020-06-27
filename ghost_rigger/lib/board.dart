import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class Board extends Game {
  Size boardSize;
  Sprite boardSprite;
  Sprite moduleSelectionSprite;

  Board() {
    boardSprite = Sprite('board.png');
    moduleSelectionSprite = Sprite('module_selection_area.png');
  }

  void render(Canvas canvas) {
    canvas.save();
    canvas.rotate(1.5708);
    canvas.translate(0, -boardSize.height);

    var boardRect = Rect.fromLTWH(0, 0, boardSize.width, boardSize.height);
    boardSprite.renderRect(canvas, boardRect);

    var moduleSelectionRect = Rect.fromLTWH(boardSize.width, 0, boardSize.height * 0.253, boardSize.height);
    moduleSelectionSprite.renderRect(canvas, moduleSelectionRect);

    canvas.restore();
  }

  void update(double t) {
    // TODO: implement update
  }

  void resize(Size size) {
    print(size);
    var boardHeight = size.width * 0.77;
    var boardWidth = boardHeight * 1.559;
    boardSize = Size(boardWidth, boardHeight);
    super.resize(size);
  }
}