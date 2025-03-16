import 'package:flutter/material.dart';

/// {@template crt_background}
/// [BoxDecoration] that provides a CRT-like background effect.
/// {@endtemplate}
class CrtBackground extends BoxDecoration {
  /// {@macro crt_background}
  const CrtBackground()
      : super(
          gradient: const LinearGradient(
            begin: Alignment(1, 0.015),
            stops: [0.0, 0.5, 0.5, 1],
            colors: [
              Color(0xFF0C32A4),
              Color(0xFF0C32A4),
              Color(0xFF274E54),
              Color(0xFF274E54),
            ],
            tileMode: TileMode.repeated,
          ),
        );
}
