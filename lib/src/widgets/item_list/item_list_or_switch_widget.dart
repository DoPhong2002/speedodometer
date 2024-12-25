import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/constants/app_colors.dart';
import '../../utils/style_utils.dart';

class ItemListOrSwitchWidget extends StatelessWidget {
  const ItemListOrSwitchWidget({
    super.key,
    required this.title,
    this.valueNotifier,
    this.onChangedSwitch,
    this.rightWidget,
    this.iconLeft,
    this.onTapItem,
    this.textRight,
  });

  final String title;
  final ValueNotifier<bool>? valueNotifier;
  final Function(bool value)? onChangedSwitch;
  final Function()? onTapItem;
  final Widget? iconLeft;
  final Widget? rightWidget;
  final String? textRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                iconLeft ?? Container(),
                SizedBox(width: 12.w),
                Text(title, style: StyleUtils.style.white.regular.s16),
              ],
            ),
            Row(
              children: [
                Row(children: [
                  Text(
                    textRight ?? '',
                    style: StyleUtils.style.gray2.medium.s14,
                  ),
                  rightWidget ?? Container()
                ]),
                if (onChangedSwitch != null)
                  ValueListenableBuilder<bool>(
                    valueListenable: valueNotifier ?? ValueNotifier(false),
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        if (valueNotifier != null) {
                          valueNotifier!.value = !value;
                          onChangedSwitch!(valueNotifier!.value);
                        } else {
                          onChangedSwitch!(!value);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: const Color(0xff808080).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30.h),
                        ),
                        padding: EdgeInsets.all(2.4.h),
                        width: 48,
                        height: 24,
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          alignment: value
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.h),
                                color: Colors.white,
                                gradient:
                                    value ? AppColors.borderGradient : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
