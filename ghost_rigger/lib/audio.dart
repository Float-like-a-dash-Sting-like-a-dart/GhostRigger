import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/audio_pool.dart';

enum Song { GAME, MENU }

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
  static bool inited = false;

  static Map<String, AudioPool> sfx = {};

  static Future init() async {
    musicPlayer = AudioCache(prefix: 'audio/bgm/', fixedPlayer: AudioPlayer());
    await musicPlayer.loadAll(['menu.mp3']);
    await musicPlayer.fixedPlayer.setReleaseMode(ReleaseMode.LOOP);

    final sounds = [
      'block.wav',
    ];
    final ps = sounds.map((s) {
      return loadSfx(s).then((value) => sfx[s] = value);
    });
    await Future.wait(ps);

    inited = true;
  }

  static void playSfx(String file) {
    if (!isPaused) {
      sfx[file].start();
    }
  }

  static void play(Song song) async {
    Audio.song = song;
    switch (song) {
      case Song.GAME:
        await musicPlayer.loop('music.mp3');
        break;
      case Song.MENU:
        await musicPlayer.loop('menu.mp3');
        break;
    }
    await _updatePlayer();
  }

  static void resume() {
    isPaused = false;
    _updatePlayer();
  }

  static void pause() {
    isPaused = true;
    _updatePlayer();
  }

  static Future _updatePlayer() async {
    if (!inited) {
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
