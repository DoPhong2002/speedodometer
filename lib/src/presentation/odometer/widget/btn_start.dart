import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';

class BtnStart extends StatelessWidget {
  const BtnStart({
    super.key,
    required this.callback,
    this.hideIcon = true,
  });

  final VoidCallback callback;
  final bool hideIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.dividerGradient,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            height: 43,
            width: 200,
            decoration: const BoxDecoration(
              gradient: AppColors.buttonGradient,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SvgPicture.asset(Assets.icons.map.icStart.path),
                5.horizontalSpace,
                Text(
                  context.l10n.cast_start,
                  style: StyleUtils.style.white.bold.s16,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
