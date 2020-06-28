import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../hacking_device.dart';
import '../device_module_base.dart';
import 'piece_model.dart';

class Piece extends DeviceModuleBase {
  Sprite sprite;
  Sprite borderSprite;
  Sprite borderHighlightedSprite;
  bool isDraggable;
  int positionInBoardColumn;
  int positionInBoardRow;
  int arithmeticValue;
  bool hastTopCable;
  bool hastRightCable;
  bool hastBottomCable;
  bool hastLeftCable;
  Offset dragPosition;
  Offset offset;
  bool isLit;
  bool isInPieceSelector;
  Paint paint;

  static Piece draggedPiece;

  Piece(HackingDevice hackingDevice, PieceModel pieceModel) : super(hackingDevice) {
    isDraggable = pieceModel.isDraggable;
    positionInBoardColumn = pieceModel.positionInBoardColumn;
    positionInBoardRow = pieceModel.positionInBoardRow;
    arithmeticValue = pieceModel.arithmeticValue;
    hastTopCable = pieceModel.hastTopCable;
    hastRightCable = pieceModel.hastRightCable;
    hastBottomCable = pieceModel.hastBottomCable;
    hastLeftCable = pieceModel.hastLeftCable;
    dragPosition = null;
    isLit = false;
    isInPieceSelector = false;
    paint = Paint();
    sprite = Sprite(getSpriteName());
    borderSprite = Sprite('line_border.png');
    borderHighlightedSprite = Sprite('line_in_out.png');
  }

  String getSpriteName() {
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
    var halfWidth = width * 0.5;
    var offsetX = dragPosition == null ? offset.dx : dragPosition.dx - halfWidth;
    var offsetY = dragPosition == null ? offset.dy : dragPosition.dy - halfWidth;

    if (isLit)
      paint.color = Color.fromRGBO(0, 0, 0, 1.0);
    else
      paint.color = Color.fromRGBO(0, 0, 0, 0.6);

    area = Rect.fromLTWH(offsetX, offsetY, width, height);
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
    if (draggedPiece != this && isInPieceSelector)
      borderSprite.renderRect(canvas, area);
    else if (draggedPiece == this)
      borderHighlightedSprite.renderRect(canvas, area);

    if (arithmeticValue != 0) {
      var textStyle = TextStyle(color: Colors.white, fontFamily: 'Rajdhani', fontSize: 18);
      var textSpan = TextSpan(text: '+5', style: textStyle);
      var textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      var offset = Offset(area.left + (area.width * 0.32), area.top + (area.width * 0.32));
      textPainter.layout(minWidth: area.width * 0.34, maxWidth: area.width * 0.34);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  void update(double t) {
    // TODO: implement update
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
    if (!isDraggable ||
        hackingDevice.pieceSelector.scrollDirection != 0 ||
        (draggedPiece != null && draggedPiece != this))
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
    if (!isDraggable || draggedPiece != this)
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