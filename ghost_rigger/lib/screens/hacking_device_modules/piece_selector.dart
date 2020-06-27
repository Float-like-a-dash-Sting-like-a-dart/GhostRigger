import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';
import 'pieces/piece_base.dart';
import 'pieces/piece_test.dart';

class PieceSelector extends DeviceModuleBase {
  Sprite sprite;
  List<PieceBase> pieces;

  PieceSelector(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('module_selection_area.png');
    pieces = [
      PieceTest(hackingDevice),
    ];
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.111;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.846;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    pieces.forEach((piece) { piece.render(canvas); });
  }

  @override
  void update(double t) {
    pieces.forEach((piece) { piece.update(t); });
  }

  @override
  void onTapDown(double dX, double dY) {
    pieces.forEach((piece) { piece.onTapDown(dX, dY); });
  }

  @override
  void onTapUp(double dX, double dY) {
    pieces.forEach((piece) { piece.onTapUp(dX, dY); });
  }

  @override
  void onTap() {
    pieces.forEach((piece) { piece.onTap(); });
  }

  @override
  void onTapCancel() {
    pieces.forEach((piece) { piece.onTapCancel(); });
  }

  @override
  void onDragUpdate(double dX, double dY) {
    pieces.forEach((piece) { piece.onDragUpdate(dX, dY); });
  }

  @override
  void onDragEnd(Velocity velocity) {
    pieces.forEach((piece) { piece.onDragEnd(velocity); });
  }

  @override
  void onDragCancel() {
    pieces.forEach((piece) { piece.onDragCancel(); });
  }
}