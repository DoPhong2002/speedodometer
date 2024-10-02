import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../utils/style_utils.dart';
import '../../utils/text_utils.dart';
import '../button_widget.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    required this.contentWidget,
    this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.padding,
    required this.oneButton,
  });

  final String? title;
  final bool oneButton;
  final Widget contentWidget;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return TextUtils.checkRotateForDialog(orientation == Orientation.landscape,
        Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                gradient: AppColors.dialogGradient),
            child: SingleChildScrollView(
              padding:
                  padding ?? EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...{
                    Text(title ?? '',
                        style: StyleUtils.style.white.bold.s20),
                    SizedBox(height: 16.h),
                  } else
                    const SizedBox(),
                  if (title != '')
                    const SizedBox()
                  else
                    const SizedBox(height: 16),
                  contentWidget,
                  const SizedBox(height: 16),
                  if (!oneButton) ...{
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            onTap: onCancel ?? context.maybePop,
                            hotColor: true,
                            child: Text(
                              cancelText ?? context.l10n.cancel,
                              style: StyleUtils.style.white.bold.s16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonWidget(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            onTap: onConfirm,
                            child: Text(
                              confirmText ?? context.l10n.ok,
                              style: StyleUtils.style.white.bold.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  } else ...{
                    ButtonWidget(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onTap: onConfirm,
                      child: Text(
                        confirmText ?? context.l10n.ok,
                        style: StyleUtils.style.white.bold.s16,
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        )
      );
    });
  }

  static Future<void> showDialogWidget({
    required BuildContext context,
    String? title,
    required Widget contentWidget,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    EdgeInsetsGeometry? padding,
    bool oneButton = false,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: title,
          contentWidget: contentWidget,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          padding: padding,
          oneButton: oneButton,
        );
      },
    );
  }
}
