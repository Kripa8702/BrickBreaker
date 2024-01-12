import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_demo/src/brick_breaker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker>{
  PlayArea() : super(
    paint: Paint()..color = const Color(0xfff2e8cf),
    children: [RectangleHitbox()]
  );

  @override
  void onLoad() {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}