import 'package:flutter/material.dart';
import 'package:fx_framework/fx_framework.dart';
import 'package:tolyui/basic/button/toly_action.dart';

import '../../router/app_route.dart';


class SettingButton extends StatelessWidget {
  final bool active;

  const SettingButton({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    Color color = active ? const Color(0xFF8D6EFF) : const Color(0xFF6A6A8A);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Center(
        child: TolyAction(
          selected: active,
          child: Icon(Icons.settings, color: color),
          onTap: () => context.go(AppRoute.settings.url),
        ),
      ),
    );
  }
}
