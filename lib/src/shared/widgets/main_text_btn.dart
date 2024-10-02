import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extension/context_extension.dart';

class MainTextBtn extends StatelessWidget {
  const MainTextBtn({
    super.key,
    required this.title,
    this.radius,
    this.vertical,
    required this.onTap,
    this.isLoading,
    this.disable,
    this.background,
    this.textColor,
  });
  final String title;
  final double? radius;
  final double? vertical;
  final VoidCallback? onTap;
  final bool? isLoading;
  final bool? disable;
  final Color? background;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical ?? 12.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15),
          color: disable != null && disable!
              ? const Color(0xffC6C6C6)
              : background ?? context.colorScheme.primary,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? context.colorScheme.background,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
