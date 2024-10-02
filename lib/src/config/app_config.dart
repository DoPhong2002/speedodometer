import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../shared/mixin/system_ui_mixin.dart';
import 'di/di.dart';

class AppConfig with SystemUiMixin {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  Future<void> init() async {
    await Future.wait([
      _initHydrateBlocStorage(),
    ]);
    configureDependencies();
    await _settingSystemUI();
  }

  Future<HydratedStorage> _initHydrateBlocStorage() async {
    final Directory documentDir = await getApplicationDocumentsDirectory();
    final dataDir =
        Directory('${documentDir.path}${Platform.pathSeparator}data');
    Hive.init(dataDir.path);
    return HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: dataDir);
  }

  //show hide bottom navigation bar of device
  Future<void> _settingSystemUI() async {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));

      hideNavigationBar();
      SystemChrome.setSystemUIChangeCallback(
          (bool systemOverlaysAreVisible) async {
        if (systemOverlaysAreVisible) {
          Future<void>.delayed(
            const Duration(seconds: 3),
            hideNavigationBar,
          );
        }
      });
    }
  }
}
