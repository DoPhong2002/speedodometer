import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/di/di.dart';
import '../../../gen/fonts.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../utils/unit_utils.dart';
import '../../setting/bloc/setting_bloc.dart';
import '../../setting/compass/cubit/compass_cubit.dart';
import '../cubit/speed_cubit.dart';
import '../cubit/timer_cubit.dart';

class RowRunTimeOmeter extends StatelessWidget {
  const RowRunTimeOmeter({
    super.key,
    required this.orient,
  });

  final Orientation orient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: orient == Orientation.portrait ? 24 : 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: BlocBuilder<SpeedCubit, SpeedState>(
                  builder: (context, stateSpeed) {
                    return BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, stateSetting) {
                        return TextUtils.cardNumberUnit(
                          context,
                          context.l10n.distance,
                          '${(stateSpeed.distanceTravelled / 6000).convertUnit(stateSetting.distanceUnit)}',
                          stateSetting.distanceUnit,
                          style: StyleUtils.style.s18.bold.textMap.copyWith(
                              fontFamily: stateSetting.fontType == 0
                                  ? FontFamily.sfpro
                                  : FontFamily.dsdigi,
                              fontSize: stateSetting.fontType == 0 ? 16 : 18),
                          padding: 16,
                        );
                      },
                    );
                  },
                ),
              ),
              if (orient == Orientation.portrait)
                16.horizontalSpace
              else
                8.horizontalSpace,
              Expanded(
                child: BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    return BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, stateSetting) {
                        return TextUtils.cardNumber(context,
                            context.l10n.totalTime, _formatTime(state.duration),
                            style: StyleUtils.style.s16.bold.textMap.copyWith(
                                fontFamily: stateSetting.fontType == 0
                                    ? FontFamily.sfpro
                                    : FontFamily.dsdigi,
                                fontSize: stateSetting.fontType == 0 ? 16 : 19),
                            padding: 16);
                      },
                    );
                  },
                ),
              )
            ],
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: BlocBuilder<SpeedCubit, SpeedState>(
                  bloc: getIt<SpeedCubit>(),
                  builder: (context, state) {
                    return BlocBuilder<SettingBloc, SettingState>(
                      bloc: getIt<SettingBloc>(),
                      builder: (context, stateSetting) {
                        return TextUtils.cardNumberUnit(
                            context,
                            context.l10n.maxSpeed,
                            '${state.maxSpeedOnTime.convertUnit(stateSetting.speedUnit)}',
                            stateSetting.speedUnit,
                            style: StyleUtils.style.s16.bold.textMap.copyWith(
                                fontFamily: stateSetting.fontType == 0
                                    ? FontFamily.sfpro
                                    : FontFamily.dsdigi,
                                fontSize: stateSetting.fontType == 0 ? 16 : 18),
                            padding: 16);
                      },
                    );
                  },
                ),
              ),
              if (orient == Orientation.portrait)
                16.horizontalSpace
              else
                8.horizontalSpace,
              Expanded(
                child: BlocBuilder<CompassCubit, CompassState>(
                  builder: (context, state) {
                    if (state.hasError) {
                      return TextUtils.cardNumber(
                          context, context.l10n.direction, 'None');
                    }

                    if (state.direction == null) {
                      return TextUtils.cardNumber(
                          context, context.l10n.direction, 'None');
                    }
                    return TextUtils.cardNumber(
                        context, context.l10n.direction, state.angle);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    final secondsRemaining = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondsRemaining.toString().padLeft(2, '0')}';
  }
}
