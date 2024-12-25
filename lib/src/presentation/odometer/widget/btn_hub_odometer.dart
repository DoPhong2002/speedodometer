import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';

class BtnHudOdometer extends StatelessWidget {
  const BtnHudOdometer({
    super.key,
    required this.callback,
    this.title,
    this.linearGradient,
    this.linearGradientBtn,
  });

  final VoidCallback callback;
  final String? title;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBtn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: 2,
          width: 1.sw,
          child: Container(
            decoration: BoxDecoration(
              gradient: linearGradient ?? AppColors.dividerGradient,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            callback();
          },
          child: Container(
            height: 43,
            width: 200,
            decoration: BoxDecoration(
              gradient: linearGradientBtn ?? AppColors.buttonGradient,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  title ?? context.l10n.start,
                  style: StyleUtils.style.white.bold.s16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
