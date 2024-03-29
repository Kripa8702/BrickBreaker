import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_demo/src/brick_breaker.dart';
import 'package:flame_demo/src/components/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Ball({
    required super.position,
    required this.velocity,
    required double radius,
    required this.difficultyModifier
  }) : super(
          radius: 10,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff1e6091)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(                                       // Modify from here...
          delay: 0.35,
        ));
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if(other is Brick){
      if(position.y < other.position.y - other.size.y /2){
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y /2){
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x - other.size.x /2){
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x + other.size.x /2){
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);
    }

    else {                                                    // To here.
      debugPrint('collision with $other');
    }
  }
}
