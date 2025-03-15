
import 'package:fx_framework/fx_framework.dart';

import '../data/data.dart';

class TolyGameBoxRepo implements AppStartRepository<AppConfig>{

  const TolyGameBoxRepo();

  @override
  Future<AppConfig> initApp() async {
    WindowSizeAdapter.setSize();
    return AppConfig();
  }

}