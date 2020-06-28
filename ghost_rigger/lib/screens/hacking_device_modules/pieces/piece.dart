import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../../hacking_device.dart';
import '../device_module_base.dart';
import 'piece_model.dart';

class Piece extends DeviceModuleBase {
  Sprite sprite;
  bool isDraggable;
  int positionInBoardColumn;
  int positionInBoardRow;
  Offset dragPosition;
  Offset offset;
  Rect boundaries;

  static Piece draggedPiece;

  Piece(HackingDevice hackingDevice, PieceModel pieceModel) : super(hackingDevice) {
    sprite = Sprite(pieceModel.spriteName);
    isDraggable = pieceModel.isDraggable;
    positionInBoardColumn = pieceModel.positionInBoardColumn;
    positionInBoardRow = pieceModel.positionInBoardRow;
    dragPosition = null;
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.082;
    var height = width;
    var halfWidth = width * 0.5;
    var offsetX = dragPosition == null ? offset.dx : dragPosition.dx - halfWidth;
    var offsetY = dragPosition == null ? offset.dy : dragPosition.dy - halfWidth;
    area = Rect.fromLTWH(offsetX - 1, offsetY - 1, width + 2, height + 2);
    if (boundaries != null && draggedPiece != this) {
      canvas.save();
      canvas.clipRect(boundaries);
      sprite.renderRect(canvas, area);
      canvas.restore();
    } else
      sprite.renderRect(canvas, area);
  }

  @override
  void update(double t) {
    // TODO: implement update
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

  void executeDragging(double dX, double dY) {
    if (!isDraggable || (draggedPiece != null && draggedPiece != this))
      return;

    if (area?.contains(Offset(dX, dY)) == true) {
      draggedPiece = this;
      dragPosition = Offset(dX, dY);
    }
    else
      stopDraggingIfNecessary();
  }

  void stopDraggingIfNecessary() {
    if (!isDraggable || dragPosition == null)
      return;

    hackingDevice.board.tryToAddPiece(this);
    hackingDevice.pieceSelector.tryToAddPiece(this);
    dragPosition = null;
    draggedPiece = null;
  }
}