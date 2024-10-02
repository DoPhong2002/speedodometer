import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../config/di/di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../utils/style_utils.dart';
import '../../../map/cubit/speed_cubit.dart';
import '../../../setting/bloc/setting_bloc.dart';

class ThemeBasic extends StatelessWidget {
  ThemeBasic({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeedCubit, SpeedState>(
      bloc: getIt<SpeedCubit>(),
      builder: (context, state) {
        final orientation = MediaQuery.of(context).orientation;
        final size = orientation == Orientation.portrait ? 1.sw : 1.sh;
        double velocity = state.speed;
        velocity =
            velocity > state.speedLimit ? state.speedLimit : velocity;
        if (velocity < 0) velocity = 0;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              SizedBox(
                height: 1 * size,
                child: Image.asset(
                  Assets.images.speedOmeter.path,
                  fit: BoxFit.contain,
                  color: state.speedWarning == SpeedWarning.red
                      ? AppColors.redOmeter
                      : state.speedWarning == SpeedWarning.orange
                          ? AppColors.yellowOmeter
                          : AppColors.blueOmeter,
                ),
              ),
              Positioned.fill(
                left: 0.045 * size,
                right: 0.045 * size,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    size: 0,
                    customColors: CustomSliderColors(
                      trackColor: Colors.black,
                      progressBarColor: state.speedWarning == SpeedWarning.red
                          ? AppColors.redOmeter
                          : state.speedWarning == SpeedWarning.orange
                              ? AppColors.yellowOmeter
                              : AppColors.blueOmeter,
                      hideShadow: true,
                    ),
                    customWidths: CustomSliderWidths(
                      trackWidth: 0.035 * size,
                      progressBarWidth: 0.035 * size,
                    ),
                  ),
                  max: state.speedLimit,
                  initialValue: velocity,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: BlocBuilder<SettingBloc, SettingState>(
                    builder: (context, stateSetting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.speed.toInt()}',
                            style: StyleUtils.style.white.bold.copyWith(
                              height: 1,
                              fontSize: state.speed >= 1000 ? 60 : 70,
                              fontFamily: stateSetting.fontType == 0
                                  ? FontFamily.sfpro
                                  : FontFamily.dsdigi,
                            ),
                          ),
                          Text(
                            stateSetting.speedUnit,
                            style: StyleUtils.style.white.regular.s24,
                          ),
                        ],
                      );
                    },
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
