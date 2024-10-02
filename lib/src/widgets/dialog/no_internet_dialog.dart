import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../utils/style_utils.dart';
import '../../utils/text_utils.dart';
import '../button_widget.dart';

Future<void> showNoInternetDialog() async {
  final context = getIt<AppRouter>().navigatorKey.currentContext;
  if (context != null) {
    await showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) => const NoInternetDialog(),
    );
  }
}

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return InternetConnectionChecker().hasConnection;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: buildDialog(context),
        ),
      ),
    );
  }

  Widget buildDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: OrientationBuilder(builder: (context, orientation) {
        return TextUtils.checkRotateForDialog(
          orientation == Orientation.landscape,
          Center(
            child: Container(
              width: 297.w,
              decoration: BoxDecoration(
                gradient: AppColors.dialogGradient,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              padding: EdgeInsets.all(12.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Assets.icons.noInternet.svg(),
                  ),
                  Text(
                    context.l10n.noInternetConnection,
                    style: StyleUtils.style.white.s24.semiBold,
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  Text(
                    context.l10n.pleaseConnectInternet,
                    style: StyleUtils.style.white.s14,
                    textAlign: TextAlign.center,
                  ),
                  16.verticalSpace,
                  ButtonWidget(
                    onTap: () {
                      if (Platform.isAndroid) {
                        const OpenSettingsPlusAndroid().wifi();
                      }
                      if (Platform.isIOS) {
                        const OpenSettingsPlusIOS().wifi();
                      }
                    },
                    child: Text(
                      context.l10n.goToSetting,
                      style: StyleUtils.style.white.bold.s16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
