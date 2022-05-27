import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin DebugMixin on KeyboardHandler{

   final RectangleHitbox box = RectangleHitbox()..debugMode=true;

   void toggle(){
      box.debugMode = !box.debugMode;
   }



   @mustCallSuper
   @override
   Future<void> onLoad() async {
     add(box);
   }

   @override
   bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
      final isKeyDown = event is RawKeyDownEvent;
      if (event.logicalKey == LogicalKeyboardKey.keyI&&isKeyDown) {
         toggle();
      }
      return true;
   }


}