import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../hacking_device.dart';
import 'device_module_base.dart';

class DisplayStatus extends DeviceModuleBase {
  Sprite sprite;

  DisplayStatus(HackingDevice hackingDevice) : super(hackingDevice) {
    sprite = Sprite('display_steps_and_status.png');
  }

  @override
  void render(Canvas canvas) {
    var width = hackingDevice.gameWidth * 0.089;
    var height = hackingDevice.gameHeight * 0.274;
    var offsetX = hackingDevice.gameWidth * 0.043;
    var offsetY = hackingDevice.gameHeight * 0.19;
    area = Rect.fromLTWH(offsetX, offsetY, width, height);
    sprite.renderRect(canvas, area);
    setCaseNumberText(canvas);
    setStatusText(canvas);
  }

  void setCaseNumberText(Canvas canvas) {
    var caseText = '${hackingDevice.puzzleNumber}/${hackingDevice.numberOfPuzzles}';
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 20);
    var textSpan = TextSpan(text: caseText, style: textStyle);
    var textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr);
    var offset = Offset(
        area.left + (area.width * 0.3),
        area.top + (area.width * 0.4));
    textPainter.layout(
        minWidth: area.width,
        maxWidth: area.width);
    textPainter.paint(canvas, offset);
  }

  void setStatusText(Canvas canvas) {
    var statusText = '';
    if (hackingDevice.puzzle.simulationFinished)
      statusText = hackingDevice.puzzle.output == hackingDevice.puzzle.goal ? "PASS" : "FAIL";
    var textStyle = TextStyle(
        color: Colors.white, fontFamily: 'Rajdhani', fontSize: 17);
    var textSpan = TextSpan(text: statusText, style: textStyle);
    var textPainter = TextPainter(
        text: textSpan, textDirection: TextDirection.ltr);
    var offset = Offset(
        area.left + (area.width * (statusText == "PASS" ? 0.21 :  0.28)),
        area.top + (area.height * 0.73));
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