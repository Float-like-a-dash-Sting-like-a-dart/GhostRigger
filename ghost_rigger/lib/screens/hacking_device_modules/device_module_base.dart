import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../hacking_device.dart';

abstract class DeviceModuleBase {
  final HackingDevice hackingDevice;
  Rect area;

  DeviceModuleBase(this.hackingDevice);

  void render(Canvas canvas);
  void update(double t);

  void onTapDown(double dX, double dY) {}
  void onTapUp(double dX, double dY) {}
  void onTap() {}
  void onTapCancel() {}

  void onDragUpdate(double dX, double dY) {}
  void onDragEnd(Velocity velocity) {}
  void onDragCancel() {}
}