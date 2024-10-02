import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/di/di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../utils/style_utils.dart';
import '../../../map/cubit/speed_cubit.dart';
import '../../../setting/bloc/setting_bloc.dart';

class Theme4 extends StatelessWidget {
  const Theme4({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = orientation == Orientation.portrait ? 1.sw : 1.sh;
    final offset = orientation == Orientation.portrait ? 0.sw : 0.sh;
    return BlocBuilder<SpeedCubit, SpeedState>(
      bloc: getIt<SpeedCubit>(),
      builder: (context, state) {
        return BlocBuilder<SettingBloc, SettingState>(
          builder: (context, stateSetting) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  SizedBox(
                    height: 1 * size, //1.sh when horizontal
                    child: Image.asset(
                      pathImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: BlocBuilder<SpeedCubit, SpeedState>(
                          builder: (context, state) {
                        var velocity = state.speed;
                        if (velocity < 0) velocity = 0.0;
                        final turn = velocity > maxSpeed ? maxSpeed : velocity;
                        final double oneKm = 0.0622 / (maxSpeed / 10);
                        return AnimatedRotation(
                          turns: -0.56 + oneKm * turn,
                          duration: const Duration(milliseconds: 3000),
                          child: Transform.translate(
                            offset: Offset(offset, -0.0115 * size),
                            child: Assets.images.odometer.theme4.icCursorPng
                                .image(width: 0.56 * size, fit: BoxFit.fill),
                          ),
                        );
                      }),
                    ),
                  ),
                  /*Positioned.fill(
                child: Center(
                  child: Assets.images.imgCenterDial1.image(
                    height: 100,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )*/

                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.speed.toInt()}',
                            style: StyleUtils.style.textPurple1.bold.copyWith(
                              height: 1,
                              fontSize: state.speed >= 1000 ? 40 : 50,
                              fontFamily: stateSetting.fontType == 0
                                  ? FontFamily.sfpro
                                  : FontFamily.dsdigi,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 0.1.sw,
                    right: 0.sw,
                    child: Center(
                      child: Text(
                        stateSetting.speedUnit,
                        style: StyleUtils.style.textPurple1.regular.s16,
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
