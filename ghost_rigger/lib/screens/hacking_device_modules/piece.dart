import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import '../models/piece_model.dart';

class Piece extends DeviceModuleBase {
  Sprite sprite;
  Sprite borderSprite;
  Sprite borderHighlightedSprite;
  int positionInBoardColumn;
  int positionInBoardRow;
  int arithmeticValue;
  ArithmeticOperation arithmeticOperation;
  bool hastTopCable;
  bool hastRightCable;
  bool hastBottomCable;
  bool hastLeftCable;
  bool isInOrOut;
  Offset dragPosition;
  Offset offset;
  Offset position;
  bool isLit;
  bool isInPieceSelector;
  Paint paint;

  static Piece draggedPiece;

  Piece(HackingDevice hackingDevice, PieceModel pieceModel) : super(hackingDevice) {
    positionInBoardColumn = pieceModel.positionInBoardColumn;
    positionInBoardRow = pieceModel.positionInBoardRow;
    arithmeticValue = pieceModel.arithmeticValue;
    arithmeticOperation = pieceModel.arithmeticOperation;
    isInOrOut = pieceModel.isInOrOut;
    hastTopCable = !isInOrOut ? pieceModel.hastTopCable : true;
    hastRightCable = !isInOrOut ? pieceModel.hastRightCable : true;
    hastBottomCable = !isInOrOut ? pieceModel.hastBottomCable : true;
    hastLeftCable = !isInOrOut ? pieceModel.hastLeftCable : true;
    dragPosition = null;
    isLit = false;
    isInPieceSelector = false;
    paint = Paint();
    sprite = Sprite(getSpriteName());
    borderSprite = Sprite('line_border.png');
    borderHighlightedSprite = Sprite('line_in_out.png');
  }

  String getSpriteName() {
    if (isInOrOut)
      return 'line_in_out.png';

    var spriteName = '';
    if (hastRightCable && hastBottomCable)
      spriteName = 'bent';
    else if (hastBottomCable && hastLeftCable)
      spriteName = 'bent_2';
    else if (hastLeftCable && hastTopCable)
      spriteName = 'bent_3';
    else if (hastTopCable && hastRightCable)
      spriteName = 'bent_4';
    else if (hastTopCable && hastBottomCable)
      spriteName = 'vertical';
    else
      spriteName = 'horizontal';

    if (arithmeticValue != 0)
      return 'line_number_$spriteName.png';
    else
      return 'line_$spriteName.png';
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.082;
    var height = width;

    if (isLit)
      paint.color = Color.fromRGBO(0, 0, 0, 1.0);
    else
      paint.color = Color.fromRGBO(0, 0, 0, 0.6);

    area = Rect.fromLTWH(position.dx, position.dy, width, height);
    var isInBoard = positionInBoardRow != -1;
    var isBeingDragged = draggedPiece == this;
    if (hackingDevice.pieceSelector.area != null && !isInBoard && !isBeingDragged) {
      canvas.save();
      canvas.clipRect(hackingDevice.pieceSelector.area);
      executeRender(canvas);
      canvas.restore();
    } else
      executeRender(canvas);
  }

  void executeRender(Canvas canvas) {
    sprite.renderRect(canvas, area, overridePaint: paint);

    if (!isInOrOut) {
      // Normal piece
      if (draggedPiece != this && isInPieceSelector)
        borderSprite.renderRect(canvas, area);
      else if (draggedPiece == this)
        borderHighlightedSprite.renderRect(canvas, area);
      if (arithmeticValue != 0) {
        arithmeticOperation = arithmeticOperation ?? ArithmeticOperation.add;
        var symbol = '';
        var extraOffsetX = 0.0;
        switch (arithmeticOperation) {
          case ArithmeticOperation.add:
            symbol = '+';
            extraOffsetX = 0;
            break;
          case ArithmeticOperation.subtract:
            symbol = '-';
            extraOffsetX = area.width * 0.05;
            break;
          case ArithmeticOperation.multiply:
            symbol = 'x';
            extraOffsetX = area.width * 0.055;
            break;
        }
        var text = '$symbol$arithmeticValue';
        var textStyle = TextStyle(
            color: Colors.white, fontFamily: 'Rajdhani', fontSize: 18);
        var textSpan = TextSpan(text: text, style: textStyle);
        var textPainter = TextPainter(
            text: textSpan, textDirection: TextDirection.ltr);
        var offset = Offset(
            area.left + (area.width * 0.32) + extraOffsetX,
            area.top + (area.width * 0.32));
        textPainter.layout(
            minWidth: area.width * 0.34,
            maxWidth: area.width * 0.34);
        textPainter.paint(canvas, offset);
      }
    } else {
      // Input or output piece
      var text = arithmeticValue != 0
          ? '$arithmeticValue'
          : 'OUT';
      var textStyle = TextStyle(
          color: Colors.white, fontFamily: 'Rajdhani', fontSize: 18);
      var textSpan = TextSpan(text: text, style: textStyle);
      var textPainter = TextPainter(
          text: textSpan, textDirection: TextDirection.ltr);
      var extraOffsetX = arithmeticValue != 0 ? area.width * 0.1 : -area.width * 0.05;
      var offset = Offset(
          area.left + (area.width * 0.32) + extraOffsetX,
          area.top + (area.width * 0.31));
      textPainter.layout(
          minWidth: area.width,
          maxWidth: area.width);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  void update(double t) {
    var width = hackingDevice.gameWidth * 0.082;
    var halfWidth = width * 0.5;
    var desiredPositionX = dragPosition == null ? offset.dx : dragPosition.dx - halfWidth;
    var desiredPositionY = dragPosition == null ? offset.dy : dragPosition.dy - halfWidth;
    if (position == null || dragPosition != null) {
      position = Offset(desiredPositionX, desiredPositionY);
      return;
    }

    // Instead of moving the piece directly to its final position, we move it closer to it to animate the movement
    var distanceX = (position.dx - desiredPositionX).abs();
    var distanceY = (position.dy - desiredPositionY).abs();
    var deltaX = position.dx < desiredPositionX ? (1000 * t) : (-1000 * t);
    var deltaY = position.dy < desiredPositionY ? (1000 * t) : (-1000 * t);

    // We slow down the shortest path (either vertical or horizontal) to ensure the movement follows a straight line
    var distanceRatio = distanceX / distanceY;
    if (distanceRatio > 1)
      deltaY *= 1.0 / distanceRatio;
    else if (distanceRatio < 1)
      deltaX *= distanceRatio;

    // Finally, we apply the calculations to set the next position
    var positionX = (distanceX <= deltaX.abs()) ? desiredPositionX : position.dx + deltaX;
    var positionY = (distanceY <= deltaY.abs()) ? desiredPositionY : position.dy + deltaY;
    position = Offset(positionX, positionY);
  }

  @override
  void onTapDown(double dX, double dY) {
    executeDragging(dX, dY, updatePosition: false);
  }

  @override
  void onTapCancel() {
    stopDraggingIfNecessary();
  }

  @override
  void onTapUp(double dX, double dY) {
    stopDraggingIfNecessary();
  }

  @override
  void onTap() {
    stopDraggingIfNecessary();
  }

  @override
  void onDragUpdate(double dX, double dY) {
    executeDragging(dX, dY);
  }

  @override
  void onDragEnd(Velocity velocity) {
    stopDraggingIfNecessary();
  }

  @override
  void onDragCancel() {
    stopDraggingIfNecessary();
  }

  void executeDragging(double dX, double dY, {bool updatePosition = true}) {
    if (hackingDevice.pieceSelector.scrollDirection != 0 ||
        (positionInBoardRow != -1 && !hackingDevice.board.validCells[positionInBoardRow][positionInBoardColumn]) ||
        (draggedPiece != null && draggedPiece != this) ||
        hackingDevice.puzzle.simulationRunning ||
        hackingDevice.isShowingInfo)
      return;

    if (draggedPiece == this || area?.contains(Offset(dX, dY)) == true) {
      draggedPiece = this;
      if (updatePosition)
        dragPosition = Offset(dX, dY);
    }
    else
      stopDraggingIfNecessary();
  }

  void stopDraggingIfNecessary() {
    if (draggedPiece != this)
      return;

    // We need to keep the order of these calls to avoid a weird issue that blocks the UI
    var previousDragPosition = dragPosition;
    dragPosition = null;
    draggedPiece = null;
    if (previousDragPosition != null) {
      hackingDevice.board.tryToAddPiece(this, previousDragPosition);
      hackingDevice.pieceSelector.tryToAddPiece(this, previousDragPosition);
    }
  }
}