import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/di/di.dart';
import '../data/local/shared_preferences_manager.dart';
import '../data/local/timer_manager.dart';
import '../shared/constants/app_colors.dart';
import '../shared/cubit/hide_navigation_bar_cubit.dart';
import 'style_utils.dart';

mixin TextUtils {
  static Widget cardAppBarMap(BuildContext context, String value,
      {String? unit, TextStyle? style}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.45)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: unit == null
              ? Text(
                  value,
                  textAlign: TextAlign.center,
                  style: style ?? StyleUtils.style.s16.regular.white,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value,
                        style: style ?? StyleUtils.style.white.bold.s16),
                    Text(' $unit', style: StyleUtils.style.s16.bold.white),
                  ],
                )),
    );
  }

  static Widget cardNumber(BuildContext context, String title, String value,
      {double? padding, TextStyle? style}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: padding ?? 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.05),
        ),
        gradient: AppColors.backgroundCard,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: StyleUtils.style.s16.regular.white,
              maxLines: 1,
            ),
          ),
          Text(
            value,
            style: style ?? StyleUtils.style.s16.bold.textMap,
          ),
        ],
      ),
    );
  }

  static Widget cardNumberUnit(
      BuildContext context, String title, String value, String unit,
      {double? padding, TextStyle? style}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: padding ?? 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        gradient: AppColors.backgroundCard,
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: StyleUtils.style.s16.regular.white,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding != null ? 3.0 : 0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: style ?? StyleUtils.style.s16.regular.white,
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: StyleUtils.style.s16.bold.textMap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget checkRotate(bool rotate, List<Widget> widget) {
    return rotate
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget,
          );
  }

  static Widget checkRotateForDialog(bool rotate, Widget widget) {
    return rotate
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AspectRatio(aspectRatio: 1, child: widget)],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [widget],
          );
  }

  static Widget checkExpanded(bool rotate, Widget widget) {
    return rotate
        ? Expanded(
            child: widget,
          )
        : widget;
  }

  static Widget checkScrollView(bool rotate, Widget widget) {
    return rotate
        ? SingleChildScrollView(
            child: widget,
          )
        : widget;
  }

  static Future<void> onHideScreen(bool hud) async {
    getIt<HideNavigationBarCubit>().update(true);
    TimerManager.instance.startTimer(() {
      getIt<HideNavigationBarCubit>().update(false);
    });
  }

  static Future<void> onShowScreen() async {
    TimerManager.instance.cancelTimer();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  static Future<void> settingSystemUI() async {
    final rotate = await PreferenceManager.getRotate();
    if (rotate) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
}
