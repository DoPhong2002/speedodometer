import 'package:flutter/services.dart';


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
