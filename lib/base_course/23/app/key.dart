import 'package:flutter/material.dart';


class Keys {
  Keys._();
  static GlobalKey<NavigatorState> navKey = GlobalKey(debugLabel: 'navKey');

  static NavigatorState? get navigator => navKey.currentState;

}
