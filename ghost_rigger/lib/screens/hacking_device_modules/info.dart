import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class Info extends DeviceModuleBase {
  Sprite backgroundSprite;
  bool show;
  String title;
  String text;
  Paint paint;

  Info(HackingDevice hackingDevice) : super(hackingDevice) {
    backgroundSprite = Sprite('info.png');
    show = false;
    paint = Paint();
  }

  @override
  void render(Canvas canvas) {
    if (!show)
      return;

    var width = hackingDevice.gameWidth * 0.683;
    var height = hackingDevice.gameHeight * 0.768;
    var offsetX = hackingDevice.gameWidth * 0.143;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    backgroundSprite.renderRect(canvas, area);

    setTitle(canvas);
    setText(canvas);
  }

  void setTitle(Canvas canvas) {
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 25);
    var textSpan = TextSpan(text: title, style: textStyle);
    var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left);
    var offset = Offset(
        area.left + (area.height * 0.13),
        area.top + (area.height * 0.11));
    textPainter.layout(
        minWidth: area.width - ((area.height * 0.13) * 2),
        maxWidth: area.width - ((area.height * 0.13) * 2));
    textPainter.paint(canvas, offset);
  }

  void setText(Canvas canvas) {
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 17);
    var textSpan = TextSpan(text: text, style: textStyle);
    var textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.left);
    var offset = Offset(
        area.left + (area.height * 0.13),
        area.top + (area.height * 0.27));
    textPainter.layout(
        minWidth: area.width - ((area.height * 0.13) * 2),
        maxWidth: area.width - ((area.height * 0.13) * 2));
    textPainter.paint(canvas, offset);
  }

  @override
  void update(double t) {
    // Nothing to do here
  }
}