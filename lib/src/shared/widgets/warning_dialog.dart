import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../extension/context_extension.dart';
import 'main_text_btn.dart';

class WarningDialog extends AlertDialog {
  const WarningDialog({
    super.key,
    required this.rejectText,
    required this.acceptText,
    required this.onAccepted,
    required this.titleText,
    required this.contentText,
    required this.context,
    this.color,
  });

  final BuildContext context;
  final String rejectText;
  final String acceptText;
  final String titleText;
  final String contentText;
  final VoidCallback onAccepted;
  final Color? color;

  @override
  List<Widget>? get actions => <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: MainTextBtn(
                onTap: () => Navigator.of(context).pop(),
                title: rejectText,
                background: color ?? AppColors.gray4,
                textColor: AppColors.gray1,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: MainTextBtn(
                onTap: onAccepted,
                title: acceptText,
                background: color ?? Colors.red,
              ),
            ),
          ],
        )
      ];

  @override
  Color? get surfaceTintColor => context.colorScheme.surface;

  @override
  Widget? get title => Text(
        titleText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: color ?? Colors.red,
        ),
      );

  @override
  Widget? get content => Text(
        contentText,
        textAlign: TextAlign.center,
      );
}
