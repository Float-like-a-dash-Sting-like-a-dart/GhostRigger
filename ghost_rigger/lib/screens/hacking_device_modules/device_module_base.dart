import 'dart:ui';

import '../hacking_device.dart';

abstract class DeviceModuleBase {
  final HackingDevice hackingDevice;

  DeviceModuleBase(this.hackingDevice);

  void render(Canvas canvas);

  void update(double t);
}