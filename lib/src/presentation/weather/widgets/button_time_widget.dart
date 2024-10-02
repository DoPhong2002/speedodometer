import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../utils/style_utils.dart';

class ButtonTimeWidget extends StatelessWidget {
  const ButtonTimeWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: StyleUtils.style.textBlue.regular.s16),
        10.vSpace,
        Container(
          height: 1,
          decoration: BoxDecoration(gradient: AppColors.dividerGradient),
        )
      ],
    );
  }
}
