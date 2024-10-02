// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/style_utils.dart';
import '../../utils/text_utils.dart';
import '../../widgets/button_widget.dart';
import '../constants/app_colors.dart';
import '../extension/context_extension.dart';

class RequestPermissionDialog extends StatelessWidget {
  const RequestPermissionDialog({
    super.key,
    required this.context,
    required this.title,
    required this.contentText,
    this.onClosed,
    this.buttonText,
    this.onButtonTap,
    this.pathImage,
    this.showMainBtn = true,
    this.heightBtn = 56,
    this.hideClose = false,
    this.widgetAction,
    this.heightImage,
    this.colorImage = AppColors.textMap,
  });

  final BuildContext context;
  final String title;
  final String contentText;
  final VoidCallback? onClosed;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final String? pathImage;
  final bool? showMainBtn;
  final bool? hideClose;
  final int? heightBtn;
  final List<Widget>? widgetAction;
  final double? heightImage;
  final Color? colorImage;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return TextUtils.checkRotateForDialog(
          orientation == Orientation.landscape,
          Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                gradient: AppColors.dialogGradient,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      12.verticalSpace,
                      if (pathImage != null) ...[
                        SvgPicture.asset(
                          pathImage!,
                          height: heightImage ?? 120.h,
                          width: heightImage ?? 120.w,
                          color: colorImage,
                        ),
                        //16.verticalSpace,
                      ],
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: StyleUtils.style.s18.semiBold.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4.h, left: 10.w, right: 10.w, bottom: 24.h),
                        child: Text(
                          contentText,
                          textAlign: TextAlign.center,
                          style: StyleUtils.style.s16.white,
                        ),
                      ),
                      Column(
                        children: widgetAction ??
                            [
                              if (showMainBtn != null && showMainBtn!)
                                ButtonWidget(
                                  onTap: onButtonTap ?? () => openAppSettings(),
                                  child: Text(
                                    buttonText ?? context.l10n.goToSetting,
                                    style: StyleUtils.style.white.bold.s16,
                                  ),
                                )
                            ],
                      )
                    ],
                  ),
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: hideClose != null && !hideClose!
                        ? GestureDetector(
                            onTap: onClosed ??
                                () {
                                  context.maybePop();
                                },
                            child: const Icon(
                              Icons.close_rounded,
                              color: AppColors.whiteF5,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          )
      );
    });
  }
}
