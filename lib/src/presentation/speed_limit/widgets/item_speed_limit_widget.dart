import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/fonts.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';
import '../../setting/bloc/setting_bloc.dart';
import '../bloc/speed_limit_bloc.dart';

class ItemSpeedLimitWidget extends StatelessWidget {
  const ItemSpeedLimitWidget({
    super.key,
    this.iconLeft,
    this.onTapItem,
    this.textRight,
    required this.itemSpeed,
  });

  final Function()? onTapItem;
  final Widget? iconLeft;
  final String? textRight;
  final ItemSpeed itemSpeed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTapItem,
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Assets.icons.settings.language.svg(),
                        SvgPicture.asset(itemSpeed.path, width: 32, height: 32),
                        SizedBox(width: 16.w),
                        Text(itemSpeed.title,
                            style: StyleUtils.style.white.regular.s16),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${itemSpeed.speed} ',
                            style: StyleUtils.style.gray2.medium.s14.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                fontFamily: state.fontType == 0
                                    ? FontFamily.sfpro
                                    : FontFamily.dsdigi,
                                fontSize: state.fontType == 0 ? 16 : 17.5),
                          ),
                          TextSpan(
                            text: state.speedUnit,
                            style: StyleUtils.style.gray2.medium.s14.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontFamily: FontFamily.sfpro,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (!itemSpeed.validate)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: context.l10n.validate,
                        style: StyleUtils.style.regular.textRed.s16),
                    TextSpan(
                      text: ' 0 - ',
                      style: StyleUtils.style.regular.textRed.s16.copyWith(
                          fontFamily: state.fontType == 0
                              ? FontFamily.sfpro
                              : FontFamily.dsdigi,
                          fontSize: state.fontType == 0 ? 16 : 16.5),
                    ),
                    TextSpan(
                      text: '${itemSpeed.speedLimit}',
                      style: StyleUtils.style.regular.textRed.s16.copyWith(
                          fontFamily: state.fontType == 0
                              ? FontFamily.sfpro
                              : FontFamily.dsdigi,
                          fontSize: state.fontType == 0 ? 16 : 16.5),
                    ),
                  ],
                ),
              )
            else
              const SizedBox()
          ],
        );
      },
    );
  }
}
