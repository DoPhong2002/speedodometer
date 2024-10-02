import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../shared/constants/app_colors.dart';
import '../utils/text_utils.dart';

enum BackgroundType { bg, pre2Bg, preThirdBg }

extension BackgroundExt on BackgroundType {
  AssetGenImage get imagePath {
    switch (this) {
      case BackgroundType.bg:
        return Assets.images.background;
      case BackgroundType.preThirdBg:
        return Assets.images.prenium3Bg;
      case BackgroundType.pre2Bg:
        return Assets.images.prenium2Bg;
    }
  }
}

class GpsBackground extends StatelessWidget {
  const GpsBackground({
    required this.child,
    this.bottomView,
    this.type = BackgroundType.bg,
    super.key,
  });

  final BackgroundType type;
  final Widget child;
  final Widget? bottomView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            type.imagePath.path,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.premiumBgGradient,
            ),
          ),
        ),
        child,
        if (bottomView != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: bottomView!,
          ),
      ],
    );
  }
}

class GpsBackgroundHome extends StatelessWidget {
  const GpsBackgroundHome({
    required this.child,
    this.bottomView,
    this.type = BackgroundType.bg,
    this.hud = false,
    super.key,
  });

  final BackgroundType type;
  final Widget child;
  final Widget? bottomView;
  final bool hud;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            type.imagePath.path,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.premiumBgGradient,
            ),
          ),
        ),
        GestureDetector(onTap: () => TextUtils.onHideScreen(hud), child: child),
        if (bottomView != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: bottomView!,
          ),
      ],
    );
  }
}
