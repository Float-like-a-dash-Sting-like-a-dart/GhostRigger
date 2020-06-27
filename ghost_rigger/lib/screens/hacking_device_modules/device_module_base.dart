import 'dart:ui';

import '../hacking_device.dart';

abstract class DeviceModuleBase {
  final HackingDevice hackingDevice;
  Rect area;

  DeviceModuleBase(this.hackingDevice);

  void render(Canvas canvas);

  void update(double t);

  void onTapDown(double dX, double dY);

  void onTapUp(double dX, double dY);
}