import 'package:flutter/services.dart';

import '../../global/global.dart';

mixin SystemUiMixin {
  void hideNavigationBar() {
    setBehavior(SystemUiMode.manual);
  }

  void setBehavior(SystemUiMode mode) {
    SystemChrome.setEnabledSystemUIMode(mode, overlays: <SystemUiOverlay>[
      SystemUiOverlay.top,
    ]);
  }
}
