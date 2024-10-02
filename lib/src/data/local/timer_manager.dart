import 'dart:async';
import 'package:flutter/material.dart';

class TimerManager {
  TimerManager._privateConstructor();

  static final TimerManager instance = TimerManager._privateConstructor();
  Timer timer = Timer(Duration.zero, () {});

  void startTimer(VoidCallback callback) {
    // Ensure previous timer is canceled before starting a new one
    timer.cancel();
    timer = Timer(const Duration(seconds: 5), callback);
  }

  void cancelTimer() {
    timer.cancel();
  }
}
