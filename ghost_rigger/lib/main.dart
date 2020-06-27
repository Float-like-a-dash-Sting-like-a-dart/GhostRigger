import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'audio.dart';
import 'screens/game_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/hacking_device.dart';
import 'package:flame/flame.dart';

class Main {
  static HackingDevice game;
  static Audio audio;
}

class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Audio.resume();
    } else {
      Audio.pause();
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HackingDevice game = HackingDevice();
  runApp(game.widget);

  runApp(MaterialApp(
    home: Scaffold(body: MenuScreen()),
    routes: {
      '/start': (BuildContext ctx) => Scaffold(body: game.widget),
      '/credits': (BuildContext ctx) => Scaffold(body: GameScreen()),
    },
  ));

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.landscapeLeft);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  tapper.onTapUp = game.onTapUp;
  tapper.onTap = game.onTap;
  tapper.onTapCancel = game.onTapCancel;
  Flame.images.loadAll(<String>[
    'main.png',
    'left.png',
    'right.png',
    'board.png',
    'display_goal.png',
    'display_output.png',
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

  WidgetsBinding.instance.addObserver(_Handler());
}
