import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/weather.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../utils/style_utils.dart';
import '../../../utils/time_utlil.dart';
import '../cubits/weather_cubit.dart';

class ItemSummaryWidget extends StatelessWidget {
  const ItemSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, Weather>(
      bloc: context.read<WeatherCubit>(),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.h),
          margin: EdgeInsets.all(24.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.summary,
                    style: StyleUtils.style.white.bold.s14.copyWith(
                      height: 1,
                    ),
                  ),
                  Text(
                    DateTime.now().toString().convertToMMMd(),
                    style: StyleUtils.style.white.bold.s14,
                  ),
                ],
              ),
              24.vSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  itemIconWithText(
                    icon: Assets.icons.weather.temperature.path,
                    context.l10n.feelLike,
                    '${state.current?.feelslikeC?.round() ?? 0}°',
                  ),
                  itemIconWithText(
                    icon: Assets.icons.weather.cloud.path,
                    context.l10n.cloud,
                    '${state.current?.cloud?.round() ?? 0}%',
                  ),
                  itemIconWithText(
                    icon: Assets.icons.weather.haze.path,
                    context.l10n.wind,
                    '${state.current?.windKph?.round() ?? 0} km/h',
                  ),
                ],
              ),
              24.vSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  itemIconWithText(
                    iconData: Icons.visibility_outlined,
                    context.l10n.vision,
                    '${state.current?.visKm?.round() ?? 0} km',
                  ),
                  itemIconWithText(
                    icon: Assets.icons.weather.sunSet.path,
                    context.l10n.uv,
                    '${state.current?.humidity?.round() ?? 0}',
                  ),
                  itemIconWithText(
                    icon: Assets.icons.weather.drop.path,
                    context.l10n.humidity,
                    '${state.current?.humidity?.round() ?? 0}%',
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget itemIconWithText(String title, String value,
      {String? icon, IconData? iconData}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: Colors.white,
              size: 19.h,
            )
          else
            SvgPicture.asset(
              icon ?? '',
              height: 19.h,
              width: 19.h,
            ),
          Text(
            title,
            style: StyleUtils.style.white.regular.s12,
          ),
          Text(
            value,
            style: StyleUtils.style.white.medium.s14,
          )
        ],
      ),
    );
  }
}
