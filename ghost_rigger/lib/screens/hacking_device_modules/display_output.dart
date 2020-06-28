import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayOutput extends DeviceModuleBase {
  Sprite sprite;

  DisplayOutput(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_output.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.187;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.639;
    var offsetY = hackingDevice.gameHeight * 0.038;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    setText(canvas);
  }

  void setText(Canvas canvas) {
    var statusText = hackingDevice.puzzle.output != 0 ? '${hackingDevice.puzzle.output}' : '-';
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 25);
    var textSpan = TextSpan(text: statusText, style: textStyle);
    var textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.end);
    var offset = Offset(
        area.left - (area.width * 0.12),
        area.top + (area.height * 0.18));
    textPainter.layout(
        minWidth: area.width,
        maxWidth: area.width);
    textPainter.paint(canvas, offset);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}