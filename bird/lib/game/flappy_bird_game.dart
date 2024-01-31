import 'dart:async';

import 'package:bird/companents/background.dart';
import 'package:bird/companents/bird.dart';
import 'package:bird/companents/ground.dart';
import 'package:bird/companents/pipe_group.dart';
import 'package:bird/game/configuration.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();
  late TextComponent score;
  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([Background(), Ground(), bird = Bird(), score = buildScore()]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        text: 'Score : ${bird.score}',
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Game'),
        ));
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score : ${bird.score}';
  }
}
