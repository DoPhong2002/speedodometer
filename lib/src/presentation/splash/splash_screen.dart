import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../utils/style_utils.dart';
import '../../widgets/gps_background.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> setInitScreen() async {
    context.replaceRoute(LanguageRoute(isFirst: true));
  }

  Future<void> _init() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
    ]);
    setInitScreen();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Image.asset(
                        Assets.images.logo.roundedLogo.path,
                        width: 215,
                        height: 215,
                        fit: BoxFit.contain,
                      ),
                    ),
                    16.vSpace,
                    Text(context.l10n.gpsSpeedometer,
                        style: StyleUtils.style.white.s24.semiBold),
                    Text(context.l10n.tracker,
                        style: StyleUtils.style.white.s36.semiBold),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 6,
                  ),
                ),
                15.vSpace,
                Text(context.l10n.splash_action_ads_title,
                    style: StyleUtils.style.s16.white),
              ],
            ),
            40.vSpace,
          ],
        ),
      ),
    );
  }
}
