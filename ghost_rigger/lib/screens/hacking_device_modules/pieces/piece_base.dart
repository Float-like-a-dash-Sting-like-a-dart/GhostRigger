import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../../hacking_device.dart';
import '../device_module_base.dart';

abstract class PieceBase extends DeviceModuleBase {
  Sprite sprite;
  Offset dragPosition;
  bool isDraggable;

  PieceBase(HackingDevice hackingDevice, String spriteName) : super(hackingDevice) {
    sprite = Sprite(spriteName);
    dragPosition = null;
    isDraggable = true;
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.082;
    var height = width;
    var halfWidth = width * 0.5;
    var offsetX = dragPosition == null ? hackingDevice.gameWidth * 0.846 : dragPosition.dx - halfWidth;
    var offsetY = dragPosition == null ? hackingDevice.gameHeight * 0.19 : dragPosition.dy - halfWidth;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
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
    if (!isDraggable)
      return;

    if (area.contains(Offset(dX, dY)))
      dragPosition = Offset(dX, dY);
    else
      stopDraggingIfNecessary();
  }

  void stopDraggingIfNecessary() {
    if (!isDraggable)
      return;

    if (!hackingDevice.board.tryToAddPiece(this))
      dragPosition = null;
  }
}