import 'package:bird/game/assets.dart';
import 'package:bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Score:${game.bird.score}',
                style: const TextStyle(
                    fontSize: 60, fontFamily: 'Game', color: Colors.white)),
            const SizedBox(
              height: 20,
            ),
            Image.asset(Assets.gameOver),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              onPressed: onRestart,
              child: const Text(
                "Restart",
                style: TextStyle(fontSize: 20, fontFamily: 'Game'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
