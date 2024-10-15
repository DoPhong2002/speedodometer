import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/di/di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../utils/style_utils.dart';
import '../../../setting/bloc/setting_bloc.dart';
import '../../cubit/speed_cubit.dart';

class Theme1 extends StatelessWidget {
  const Theme1({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).orientation == Orientation.portrait
        ? 1.sw
        : 1.sh;

    return BlocBuilder<SpeedCubit, SpeedState>(
      bloc: getIt<SpeedCubit>(),
      builder: (context, speedState) {
        return BlocBuilder<SettingBloc, SettingState>(
          builder: (context, settingState) {
            final velocity = speedState.speed < 0 ? 0 : speedState.speed;
            final turn = velocity > maxSpeed ? maxSpeed : velocity;
            final double oneKm = 0.755 / maxSpeed;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  SizedBox(
                    height: 1.sw,
                    child: Image.asset(pathImage, fit: BoxFit.contain),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: AnimatedRotation(
                        turns: -0.55 + oneKm * turn,
                        duration: const Duration(milliseconds: 3000),
                        child: Transform.translate(
                          offset: Offset(0.068 * size, -0.0095 * size),
                          child: Assets.images.odometer.theme1.icCursor.image(
                            width: 0.45 * size,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${speedState.speed.toInt()}',
                            style: StyleUtils.style.textPink.bold.copyWith(
                              height: 1,
                              fontSize: speedState.speed >= 1000 ? 30 : 40,
                              fontFamily: settingState.fontType == 0
                                  ? FontFamily.sfpro
                                  : FontFamily.dsdigi,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 0.4 * size,
                    child: Center(
                      child: Text(
                        settingState.speedUnit,
                        style: StyleUtils.style.textPink.regular.s16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
