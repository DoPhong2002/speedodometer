import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/di/di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../utils/style_utils.dart';
import '../../../map/cubit/speed_cubit.dart';
import '../../../setting/bloc/setting_bloc.dart';

class Theme1 extends StatelessWidget {
  const Theme1({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = orientation == Orientation.portrait ? 1.sw : 1.sh;
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
                    height: 1.sw,
                    child: Image.asset(
                      pathImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: BlocBuilder<SpeedCubit, SpeedState>(
                        builder: (context, state) {
                          final velocity = state.speed < 0 ? 0 : state.speed;
                          final turn =
                              velocity > maxSpeed ? maxSpeed : velocity;
                          final double oneKm = 0.0755 / (maxSpeed / 10);
                          return AnimatedRotation(
                            turns: -0.55 + oneKm * turn,
                            duration: const Duration(milliseconds: 3000),
                            child: Transform.translate(
                              offset: Offset(0.068 * size, -0.0095 * size),
                              child:
                                  Assets.images.odometer.theme1.icCursor.image(
                                width: 0.45 * size,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.speed.toInt()}',
                            style: StyleUtils.style.textPink.bold.copyWith(
                                height: 1,
                                fontSize: state.speed >= 1000 ? 30 : 40,
                                fontFamily: stateSetting.fontType == 0
                                    ? FontFamily.sfpro
                                    : FontFamily.dsdigi),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 0.4 * size,
                    child: Center(
                      child: Text(
                        stateSetting.speedUnit,
                        style: StyleUtils.style.textPink.regular.s16,
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
