import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../../config/di/di.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../utils/style_utils.dart';
import '../../../setting/bloc/setting_bloc.dart';
import '../../cubit/speed_cubit.dart';

class Theme2 extends StatelessWidget {
  const Theme2({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeedCubit, SpeedState>(
      bloc: getIt<SpeedCubit>(),
      builder: (context, state) {
        final orientation = MediaQuery.of(context).orientation;
        final size = orientation == Orientation.portrait ? 1.sw : 1.sh;
        var velocity = state.speed >= maxSpeed.toDouble()
            ? maxSpeed.toDouble()
            : state.speed;
        if (velocity < 0) velocity = 0;
        return BlocBuilder<SettingBloc, SettingState>(
          builder: (context, stateSetting) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 0.075 * size),
                      width: 1 * size,
                      child: Image.asset(
                        pathImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    left: 0.2 * size,
                    right: 0.2 * size,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        size: 0,
                        startAngle: 42,
                        angleRange: 272,
                        customColors: CustomSliderColors(
                          trackColor: Colors.blue.shade400,
                          progressBarColors: [
                            AppColors.textRed,
                            AppColors.color7,
                            AppColors.redOmeter,
                          ],
                          dotColor: AppColors.purpleFF89,
                        ),
                        customWidths: CustomSliderWidths(
                          trackWidth: 0.0075 * size,
                          progressBarWidth: 0.0075 * size,
                          handlerSize: 5,
                        ),
                      ),
                      max: maxSpeed.toDouble(),
                      initialValue: velocity,
                    ),
                  ),
                  Positioned.fill(
                    top: -0.075 * size,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.speed.toInt()}',
                            style: StyleUtils.style.white.bold.copyWith(
                              height: 1,
                              fontSize: state.speed >= 1000 ? 40 : 50,
                              fontFamily: stateSetting.fontType == 0
                                  ? FontFamily.sfpro
                                  : FontFamily.dsdigi,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 0.1 * size,
                    right: 0 * size,
                    child: Center(
                      child: Text(
                        stateSetting.speedUnit,
                        style: StyleUtils.style.white.regular.s16,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
