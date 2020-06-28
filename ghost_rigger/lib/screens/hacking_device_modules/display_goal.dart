import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayGoal extends DeviceModuleBase {
  Sprite sprite;

  DisplayGoal(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_goal.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.187;
    var height = hackingDevice.gameHeight * 0.125;
    var offsetX = hackingDevice.gameWidth * 0.441;
    var offsetY = hackingDevice.gameHeight * 0.038;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    setText(canvas);
  }

  void setText(Canvas canvas) {
    var text = '${hackingDevice.puzzle.goal}';
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 25);
    var textSpan = TextSpan(text: text, style: textStyle);
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