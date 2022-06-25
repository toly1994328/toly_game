import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toly_game/base_course/22/02/menu/pause.dart';
import 'app/key.dart';
import 'gen/fonts.gen.dart';
import 'menu/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'game.dart';

main() {
  runApp(const GameApp());
  DesktopWindow.setWindowSize(Size(700,300));
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Keys.navKey,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: AppLocalizations.supportedLocales[1],
      darkTheme: ThemeData(
          brightness: Brightness.dark,
        fontFamily: FontFamily.zCOOLKuaiLe
      ),
      home: const MainMenu(),
    );
  }
}


class GameWorld extends StatelessWidget {
  const GameWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget<TolyGame>(game: TolyGame(),
      overlayBuilderMap:  {
        PauseMenu.menuId: (_,game) => PauseMenu(game: game),
      },
    );
  }
}
