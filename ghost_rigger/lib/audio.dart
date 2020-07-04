import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/audio_pool.dart';

enum Song { GAME, MENU, DRAMATIC }

Future<AudioPool> loadSfx(String file) async {
  final audio =
      AudioPool(file, prefix: 'audio/sfx/', minPlayers: 2, maxPlayers: 4);
  await audio.init();
  return audio;
}

class Audio {
  static AudioCache musicPlayer;
  static Song song;
  static bool isPaused = false;
  static bool initialised = false;

  static AudioPlayer _audioPlayer;

  static Map<String, AudioPool> sfx = {};

  static Future init() async {
    musicPlayer = AudioCache(prefix: 'audio/bgm/', fixedPlayer: AudioPlayer());
    await musicPlayer
        .loadAll(['menu.mp3', 'music.mp3', 'ingame.mp3', 'intro.mp3']);
    await musicPlayer.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);

    final sounds = [
      'block.wav',
      'menu.aac',
    ];
    final ps = sounds.map((s) {
      return loadSfx(s).then((value) => sfx[s] = value);
    });
    await Future.wait(ps);

    initialised = true;
  }

  static void playSfx(String file) {
    if (!isPaused) {
      sfx[file].start();
    }
  }

  static void play(Song song, { bool stopPrevious = true }) async {
    Audio.song = song;
    if (stopPrevious)
      stop();
    switch (song) {
      case Song.GAME:
        _audioPlayer = await musicPlayer.loop('ingame.mp3');
        break;
      case Song.MENU:
        _audioPlayer = await musicPlayer.loop('menu.mp3');
        break;
      case Song.DRAMATIC:
        _audioPlayer = await musicPlayer.loop('intro.mp3');
        break;
    }
    await _updatePlayer();
  }

  static void stop() {
    _audioPlayer?.stop();
  }

  static void resume() {
    isPaused = false;
    _updatePlayer();
  }

  static void pause() {
    isPaused = true;
    _updatePlayer();
  }

  static void flipMusicOnOff() {
    if (isPaused) {
      resume();
    } else {
      pause();
    }
  }

  static Future _updatePlayer() async {
    if (!initialised) {
      return;
    }

    if (song != null) {
      if (!isPaused) {
        await musicPlayer.fixedPlayer.resume();
      } else {
        await musicPlayer.fixedPlayer.pause();
      }
    } else {
      await musicPlayer.fixedPlayer.stop();
    }
  }
}
