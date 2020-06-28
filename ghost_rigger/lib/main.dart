import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ghost_rigger/screens/newspaper_screen.dart';
import 'audio.dart';
import 'screens/chat_screen.dart';
import 'screens/decyrpt_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/credits_screen.dart';
import 'screens/game_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/hacking_device.dart';

class Main {
  static HackingDevice game;
  static int currentLevel = 1;
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

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.landscapeLeft);
  Flame.images.loadAll(<String>[
    'main.png',
    'left.png',
    'right.png',
    'board.png',
    'info.png',
    'info_intro.png',
    'display_goal.png',
    'display_output.png',
    'board.png',
    'button_ok.png',
    'button_ok_pressed.png',
    'button_skip_level.png',
    'button_skip_level_pressed.png',
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
    'button_arrow_up.png',
    'button_arrow_up_pressed.png',
    'button_arrow_down.png',
    'button_arrow_down_pressed.png',
    'display_steps_and_status.png',
    'module_selection_area.png',
    'blocked_cell.png',
    'empty_space_left_bottom_1.png',
    'empty_space_left_bottom_2.png',
    'empty_space_left_bottom_3.png',
    'empty_space_left_bottom_4.png',
    'empty_space_left_bottom_5.png',
    'empty_space_left_bottom_6.png',
    'left_door.png',
    'right_door.png',
    'line_number_bent.png',
    'line_number_bent_2.png',
    'line_number_bent_3.png',
    'line_number_bent_4.png',
    'line_number_horizontal.png',
    'line_number_vertical.png',
    'line_bent.png',
    'line_bent_2.png',
    'line_bent_3.png',
    'line_bent_4.png',
    'line_horizontal.png',
    'line_vertical.png',
    'line_border.png',
    'line_in_out.png',
  ]);
  Flame.audio.loadAll(<String>[
    'bgm/menu.mp3',
    'bgm/music.mp3',
    'bgm/ingame.mp3',
    'bgm/intro.mp3',
    'sfx/block.wav',
    'sfx/menu.aac',
  ]);

  await Audio.init();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: MenuScreen(true), //TODO save music state
      backgroundColor: Colors.black,
    ),
    routes: {
      '/start': (BuildContext ctx) {
        Main.currentLevel = 1; //TODO save the level
        return Scaffold(
          body: IntroScreen(),
          backgroundColor: Colors.black,
        );
      },
      '/level1': (BuildContext ctx) => Scaffold(
            body: GameScreen(1),
            backgroundColor: Colors.black,
          ),
      '/level2': (BuildContext ctx) => Scaffold(
            body: GameScreen(2),
            backgroundColor: Colors.black,
          ),
      '/level3': (BuildContext ctx) => Scaffold(
            body: GameScreen(3),
            backgroundColor: Colors.black,
          ),
      '/resume': (BuildContext ctx) => Scaffold(
            body: GameScreen(Main.currentLevel), //TODO save the level
            backgroundColor: Colors.black,
          ),
      '/credits': (BuildContext ctx) => Scaffold(
            body: CreditScreen(),
            backgroundColor: Colors.black,
          ),
      '/chat': (BuildContext ctx) => Scaffold(
            body: ChatScreen(),
            backgroundColor: Colors.black,
          ),
      '/newspaper': (BuildContext ctx) => Scaffold(
            body: NewspaperScreen(),
            backgroundColor: Colors.black,
          ),
      '/decrypt': (BuildContext ctx) => Scaffold(
            body: DecryptScreen(),
            backgroundColor: Colors.black,
          ),
    },
  ));

  WidgetsBinding.instance.addObserver(_Handler());
}
