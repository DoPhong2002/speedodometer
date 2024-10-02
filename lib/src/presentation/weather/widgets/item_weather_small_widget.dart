import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/weather/weather.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../utils/style_utils.dart';
import '../../../utils/time_utlil.dart';
import '../../../widgets/image/custome_cache_image.dart';

class ItemWeatherSmallWidget extends StatelessWidget {
  const ItemWeatherSmallWidget({super.key, this.hour});

  final Hour? hour;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.73.w,
            ),
            gradient: AppColors.divider4Gradient,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              gradient: AppColors.dialogGradient,
              borderRadius: BorderRadius.circular(90),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    (hour?.time ?? '').convertToAPM(),
                    style: StyleUtils.style.white.regular.s14,
                  ),
                ),
                8.vSpace,
                CustomCacheImage(
                  imageUrl: 'https:${hour?.condition?.icon ?? ''}',
                ),
                8.vSpace,
                Text(
                  '${hour?.tempC?.round() ?? 0}°',
                  style: StyleUtils.style.white.regular.s16,
                ),
              ],
            ),
          ),
        ),
        if ((hour?.time ?? '').convertToAPM() == '11PM')
          const SizedBox()
        else
          8.w.hSpace,
      ],
    );
  }
}
