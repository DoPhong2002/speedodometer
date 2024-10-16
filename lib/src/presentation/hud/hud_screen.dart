import 'dart:math' as math;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/di/di.dart';
import '../../gen/fonts.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/cubit/hide_navigation_bar_cubit.dart';
import '../../shared/extension/context_extension.dart';
import '../../utils/style_utils.dart';
import '../../widgets/gps_background.dart';
import '../odometer/cubit/speed_cubit.dart';
import '../odometer/widget/btn_hub_odometer.dart';
import '../setting/bloc/setting_bloc.dart';

@RoutePage()
class HudScreen extends StatefulWidget {
  const HudScreen({super.key});

  @override
  State<HudScreen> createState() => _HudScreenState();
}

class _HudScreenState extends State<HudScreen>
    with AutoRouteAwareStateMixin<HudScreen> {
  bool start = true;
  double value = 0;

  @override
  void initState() {
    super.initState();
    context.read<HideNavigationBarCubit>().update(false);
  }

  void onStop() {
    setState(() {
      value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GpsBackgroundHome(
      hud: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return (orientation == Orientation.portrait)
                ? Stack(
                    children: [
                      BlocBuilder<HideNavigationBarCubit, bool>(
                        builder: (contextVisible, stateVisible) {
                          return Visibility(
                            visible: stateVisible,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: SizedBox(
                                width: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: start
                                        ? AppColors.dividerHubRedGradient
                                        : AppColors.dividerHubGradient,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<HideNavigationBarCubit, bool>(
                        builder: (contextVisible, stateVisible) {
                          return Visibility(
                            visible: stateVisible,
                            child: Positioned(
                              left: -50,
                              top: 1.sh / 2.1,
                              child: Transform.flip(
                                flipY: start,
                                child: Transform.rotate(
                                  angle: math.pi / 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        start = !start;
                                      });
                                    },
                                    child: Container(
                                      height: 43,
                                      alignment: Alignment.center,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        gradient: start
                                            ? AppColors.buttonHotGradient
                                            : AppColors.buttonGradient,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      child: Text(
                                        start
                                            ? context.l10n.offHud
                                            : context.l10n.onHud,
                                        style: StyleUtils.style.white.bold.s16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 100.w,
                        ),
                        child: Transform.flip(
                          flipY: start,
                          child: Transform.rotate(
                            angle: math.pi / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<SpeedCubit, SpeedState>(
                                      bloc: getIt<SpeedCubit>(),
                                      builder: (context, state) {
                                        return BlocBuilder<SettingBloc,
                                            SettingState>(
                                          builder: (context, stateSetting) {
                                            return Text(
                                              '${state.speed.toInt()}',
                                              style: StyleUtils
                                                  .style.bold.s180.white
                                                  .copyWith(
                                                      height: 1,
                                                      fontSize:
                                                          state.speed > 999
                                                              ? 80
                                                              : state.speed > 99
                                                                  ? 96
                                                                  : 140,
                                                      fontFamily: stateSetting
                                                                  .fontType ==
                                                              0
                                                          ? FontFamily.sfpro
                                                          : FontFamily.dsdigi),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70.w),
                        child: Transform.flip(
                          flipY: start,
                          child: Transform.rotate(
                            angle: math.pi / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<SettingBloc, SettingState>(
                                  builder: (context, stateSetting) {
                                    return Text(
                                      stateSetting.distanceUnit,
                                      style: StyleUtils.style.bold.s51.white
                                          .copyWith(height: 1),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.flip(
                                flipX: start,
                                child: BlocBuilder<SpeedCubit, SpeedState>(
                                  bloc: getIt<SpeedCubit>(),
                                  builder: (context, state) {
                                    return BlocBuilder<SettingBloc,
                                        SettingState>(
                                      builder: (context, stateSetting) {
                                        return Text(
                                          '${state.speed.toInt()}',
                                          style: StyleUtils
                                              .style.bold.s180.white
                                              .copyWith(
                                                  height: 1,
                                                  fontSize: state.speed > 999
                                                      ? 80
                                                      : state.speed > 99
                                                          ? 96
                                                          : 140,
                                                  fontFamily:
                                                      stateSetting.fontType == 0
                                                          ? FontFamily.sfpro
                                                          : FontFamily.dsdigi),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Transform(
                                transform: start
                                    ? (Matrix4.identity()
                                      ..scale(-1.0, 1.0, 1.0))
                                    : Matrix4.identity()
                                  ..scale(1.0, 1.0, -1.0),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0.h),
                                  child: Column(
                                    children: [
                                      BlocBuilder<SettingBloc, SettingState>(
                                        builder: (context, stateSetting) {
                                          return Text(
                                            stateSetting.distanceUnit,
                                            style: StyleUtils
                                                .style.bold.s51.white
                                                .copyWith(height: 1),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      BlocBuilder<HideNavigationBarCubit, bool>(
                                        builder:
                                            (contextVisible, stateVisible) {
                                          return Visibility(
                                            visible: start && stateVisible,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 120),
                                              child: BtnHudOdometer(
                                                title: context.l10n.offHud,
                                                linearGradient: AppColors
                                                    .dividerRedGradient,
                                                linearGradientBtn:
                                                    AppColors.buttonHotGradient,
                                                callback: () {
                                                  setState(() {
                                                    start = !start;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              BlocBuilder<HideNavigationBarCubit, bool>(
                                builder: (contextVisible, stateVisible) {
                                  return Visibility(
                                    visible: !start && stateVisible,
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 120),
                                      child: BtnHudOdometer(
                                        title: context.l10n.onHud,
                                        linearGradient:
                                            AppColors.dividerGradient,
                                        linearGradientBtn:
                                            AppColors.buttonGradient,
                                        callback: () {
                                          setState(() {
                                            start = !start;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
