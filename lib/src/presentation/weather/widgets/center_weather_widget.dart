import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/weather.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/image/custome_cache_image.dart';
import '../cubits/weather_cubit.dart';

class CenterWeatherWidget extends StatelessWidget {
  const CenterWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return BlocBuilder<WeatherCubit, Weather>(
      bloc: context.read<WeatherCubit>(),
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (orientation == Orientation.portrait) CustomCacheImage(
                      imageUrl:
                          'https:${state.current?.condition?.icon ?? ''}',
                      height: 150.h,
                      width: 150.w,
                      fit: BoxFit.contain,
                    ) else CustomCacheImage(
                      imageUrl:
                      'https:${state.current?.condition?.icon ?? ''}',
                       width: 0.5.sw,
                      fit: BoxFit.contain,
                    ),
                    FittedBox(
                      child: Text(
                        state.current?.condition?.text ??
                            context.l10n.condition,
                        style: StyleUtils.style.white.medium.s16,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: FittedBox(
                  child: Text(
                    '${state.current?.tempC?.round() ?? '0'}°',
                    style: StyleUtils.style.white.medium.s96,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
