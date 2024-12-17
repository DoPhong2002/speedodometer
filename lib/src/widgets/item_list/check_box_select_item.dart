import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../../utils/style_utils.dart';

class CheckBoxSelectItem<T> extends StatelessWidget {
  const CheckBoxSelectItem({
    super.key,
    required this.title,
    this.textRight,
    this.styleTextRight,
    this.isShowBorder = true,
    this.value,
    this.selectedValue,
    this.onTap,
  });

  final String title;
  final String? textRight;
  final TextStyle? styleTextRight;
  final bool isShowBorder;
  final T? value;
  final T? selectedValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 13.h, top: 13.w),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: isShowBorder
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
          ),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: StyleUtils.style.white.regular.s16),
            Row(
              children: [
                Text(textRight ?? '',
                    style:
                        styleTextRight ?? StyleUtils.style.white.regular.s16),
                SizedBox(width: 8.w),
                if (value == selectedValue)
                  Assets.icons.dialog.checkboxOn.svg()
                else
                  Assets.icons.dialog.checkboxOff.svg(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
