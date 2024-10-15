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
import '../../../setting/bloc/setting_bloc.dart';
import '../../cubit/speed_cubit.dart';

class Theme6 extends StatelessWidget {
  const Theme6({super.key, required this.pathImage, required this.maxSpeed});

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
              padding: EdgeInsets.symmetric(horizontal: 24.h),
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
                        final double oneKm = 0.0755 / (maxSpeed / 10);
                        return AnimatedRotation(
                          turns: (-0.506 + oneKm * turn) <= 0.252
                              ? (-0.506 + oneKm * turn)
                              : 0.252,
                          duration: const Duration(milliseconds: 3000),
                          child: Transform.translate(
                            offset: Offset(-0.092 * size, -0.097 * size),
                            child: SvgPicture.asset(
                              Assets.images.odometer.theme6.icCursor.path,
                              width: 0.3 * size,
                            ),
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
                    right: -0.55 * size,
                    top: -0.04 * size,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.speed.toInt()}',
                          style: StyleUtils.style.white.bold.copyWith(
                            height: 1,
                            fontSize: state.speed >= 1000 ? 20 : 30,
                            fontFamily: stateSetting.fontType == 0
                                ? FontFamily.sfpro
                                : FontFamily.dsdigi,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    right: -0.55 * size,
                    top: 0.06 * size,
                    child: Center(
                      child: Text(
                        stateSetting.speedUnit,
                        style: StyleUtils.style.textPurple32.bold.s14,
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
