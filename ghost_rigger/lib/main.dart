import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'audio.dart';
import 'screens/intro_screen.dart';
import 'screens/credits_screen.dart';
import 'screens/game_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/hacking_device.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Scaffold(body: MenuScreen()),
    routes: {
      '/start': (BuildContext ctx) => Scaffold(body: IntroScreen()),
      '/resume': (BuildContext ctx) => Scaffold(body: GameScreen()),
      '/credits': (BuildContext ctx) => Scaffold(body: CreditScreen()),
    },
  ));

  await Flame.init(
      fullScreen: true, orientation: DeviceOrientation.landscapeLeft);

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
    'blocked_cell.png',
    'cable_out.png',
  ]);

  Audio.init();

  WidgetsBinding.instance.addObserver(_Handler());
}
