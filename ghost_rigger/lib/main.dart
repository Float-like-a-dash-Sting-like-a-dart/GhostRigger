import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Code/GhostRigger/ghost_rigger/lib/screens/hacking_device.dart';
import 'package:flame/flame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HackingDevice game = HackingDevice();
  runApp(game.widget);

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>[
    'main.png',
    'left.png',
    'right.png',
    'board.png',
    'display_steps_and_status.png',
    'module_selection_area.png',
  ]);
}