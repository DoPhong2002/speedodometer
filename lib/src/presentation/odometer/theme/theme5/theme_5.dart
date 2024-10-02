import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di/di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../utils/style_utils.dart';
import '../../../map/cubit/speed_cubit.dart';
import '../../../setting/bloc/setting_bloc.dart';

class Theme5 extends StatelessWidget {
  const Theme5({super.key, required this.pathImage, required this.maxSpeed});

  final String pathImage;
  final int maxSpeed;

  @override
  Widget build(BuildContext context) {
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
                    height: 1.sw, //1.sh when horizontal
                    child: Image.asset(
                      pathImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.speed.toInt()}',
                            style: StyleUtils.style.textPurple2.bold.copyWith(
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
                        style:
                            StyleUtils.style.textPurple2.regular.s16.copyWith(
                          fontFamily: stateSetting.fontType == 0
                              ? FontFamily.sfpro
                              : FontFamily.dsdigi,
                        ),
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
