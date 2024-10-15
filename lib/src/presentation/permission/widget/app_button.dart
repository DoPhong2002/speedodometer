import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.isEnable = true,
    this.isShowIcon = false,
    this.backgroundColor,
    this.secondBackgroundColor,
    this.textColor,
    this.textSecondColor,
    this.iconColor,
    this.iconSecondColor,
    required this.onTap,
    this.heightBtn,
    this.paddingVertical,
    this.widthBtn,
  });

  final String title;

  final bool isEnable;
  final bool isShowIcon;

  final LinearGradient? backgroundColor;
  final LinearGradient? secondBackgroundColor;

  final Color? textColor;
  final Color? textSecondColor;

  final Color? iconColor;
  final Color? iconSecondColor;

  final VoidCallback onTap;
  final double? heightBtn;
  final double? widthBtn;
  final double? paddingVertical;
  Color? _getTextColor() {
    return isEnable ? textColor : textSecondColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        height: heightBtn ?? 56.h,
        width: widthBtn ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 16.h),
        decoration: BoxDecoration(
          gradient: backgroundColor ?? AppColors.buttonGradient,
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Align(
              child: Text(
                title,
                style: TextStyle(
                  color: _getTextColor() ?? Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                  ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
