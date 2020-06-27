import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'screens/hacking_device.dart';
import 'package:flame/flame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HackingDevice game = HackingDevice();
  runApp(game.widget);

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  tapper.onTapUp = game.onTapUp;
  flameUtil.addGestureRecognizer(tapper);
  Flame.images.loadAll(<String>[
    'main.png',
    'left.png',
    'right.png',
    'board.png',
    'button_info.png',
    'button_info_pressed.png',
    'button_run.png',
    'button_run_pressed.png',
    'button_next_step.png',
    'button_next_step_pressed.png',
    'button_restart.png',
    'button_restart_pressed.png',
    'button_done.png',
    'button_done_pressed.png',
    'button_exit.png',
    'button_exit_pressed.png',
    'display_steps_and_status.png',
    'module_selection_area.png',
  ]);
  Flame.audio.loadAll([
    'bgm/titlescreen.mp3',
  ]);
}
