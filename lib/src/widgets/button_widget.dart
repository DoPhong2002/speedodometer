import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/constants/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    this.hotColor = false,
  });

  final VoidCallback onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool hotColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.h),
            gradient: hotColor
                ? AppColors.buttonHotGradient
                : AppColors.borderGradient),
        child: Center(child: child),
      ),
    );
  }
}
