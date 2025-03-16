import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake/snake.dart';

import '../../../logic/game_state_mixin.dart';
import '../../../model/player.dart';
import '../hud/score.dart';
import '../hud/speed.dart';
import '../hud/time.dart';
import 'game_status.dart';
import 'players.dart';
import 'settings.dart';

class ToolBar extends PositionComponent with HasGameRef<SnakeGame> {
  StreamSubscription<GameEvent>? _subscription;

  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2(size.x, 46);
    y = game.size.y - 46;
    super.onGameResize(size);
  }

  PlayerStatusBar status = PlayerStatusBar();
  Settings setting = Settings();

  @override
  FutureOr<void> onLoad() {
    double offsetX = 0;
    for (Player player in game.players) {
      PlayerBar bar = PlayerBar(player.name, player.color);
      add(bar..x = bar.position.x + offsetX);
      offsetX += bar.width + 16;
    }

    add(status);
    add(setting);
    return super.onLoad();
  }

  @override
  void onMount() {
    _subscription = game.stream.listen(_onHudChange);
    super.onMount();
  }

  @override
  void onRemove() {
    _subscription?.cancel();
  }

  void _onHudChange(GameEvent event) {
    if (event is StatusChangeEvent) {
      status.setStatus(event.status);
    }
  }
}
