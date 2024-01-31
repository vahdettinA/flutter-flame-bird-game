import 'dart:async';
import 'dart:math';

import 'package:bird/companents/pipe.dart';
import 'package:bird/game/assets.dart';
import 'package:bird/game/configuration.dart';
import 'package:bird/game/flappy_bird_game.dart';
import 'package:bird/game/pipe_position.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();
  final _random = Random();
  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGRound = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGRound / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGRound - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGRound - (centerY + spacing / 2))
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
