import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../config/di/di.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/mixin/permission_mixin.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../utils/text_utils.dart';
import '../../widgets/dialog/dialog_widget.dart';
import '../../widgets/gps_background.dart';
import '../../widgets/gradient_border_widget.dart';
import '../../widgets/grid_view_widget.dart';
import '../map/cubit/speed_cubit.dart';
import '../permission/widget/permission_home_bottom.dart';
import '../setting/bloc/setting_bloc.dart';
import '../setting/theme/cubit/theme_cubit.dart';
import '../setting/theme/theme_screen.dart';
import '../speed_limit/bloc/speed_limit_bloc.dart';
import 'theme/theme1/theme_1.dart';
import 'theme/theme2/theme_2.dart';
import 'theme/theme4/theme_4.dart';
import 'theme/theme5/theme_5.dart';
import 'theme/theme6/theme_6.dart';
import 'theme/theme_basic/theme_basic.dart';
import 'widget/action_control_widget.dart';
import 'widget/row_run_time_ometer.dart';

@RoutePage()
class SpeedometerScreen extends StatefulWidget {
  const SpeedometerScreen({
    super.key,
  });

  @override
  State<SpeedometerScreen> createState() => _SpeedometerScreenState();
}

class _SpeedometerScreenState extends State<SpeedometerScreen>
    with
        WidgetsBindingObserver,
        PermissionMixin,
        AutoRouteAwareStateMixin<SpeedometerScreen> {
  ValueNotifier<bool> permissionNotifier = ValueNotifier(false);
  final speedCubit = getIt<SettingBloc>();
  late final Map<VehicleWithSpeedLimit, ItemSpeed> speedLimits;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getSpeedLimit();
    checkPassLocation();
    super.initState();
  }

  Future<void> getSpeedLimit() async {
    speedLimits = await PreferenceManager.getSpeedLimits();
    getIt<SpeedCubit>().updateSpeedLimit(
        speedLimits.values.toList()[speedCubit.state.vehicle].speed.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<SettingBloc, SettingState>(
          builder: (bloc, stateSetting) {
            return GpsBackgroundHome(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return Scaffold(
                    appBar: GpsAppbar(
                      context,
                      context.l10n.speedometer,
                      leadingWid: 50,
                      titleCenter: true,
                      heightAppBar:
                          orientation == Orientation.landscape ? 40 : 80,
                      leadingApp: GestureDetector(
                        onTap: () {
                          final ValueNotifier<int?> selectedIndex =
                              ValueNotifier<int?>(stateSetting.vehicle);
                          DialogWidget.showDialogWidget(
                            padding: const EdgeInsets.fromLTRB(10, 24, 10, 16),
                            context: context,
                            title: context.l10n.vehicle,
                            contentWidget: GridViewWidget(
                              onTap: (index, value) {},
                              items: VehicleWithSpeedLimit.loadSpeedLimits()
                                  .values
                                  .toList(),
                              selectedIndex: selectedIndex,
                            ),
                            onConfirm: () async {
                              final Map<VehicleWithSpeedLimit, ItemSpeed>
                                  speedLimitNew =
                                  await PreferenceManager.getSpeedLimits();
                              bloc
                                  .read<SettingBloc>()
                                  .add(VehicleEvent(selectedIndex.value ?? 0));
                              getIt<SpeedCubit>().updateSpeedLimit(speedLimitNew
                                  .values
                                  .toList()[selectedIndex.value ?? 0]
                                  .speed
                                  .toDouble());
                              context.maybePop();
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: GradientBorder(
                                gradient: AppColors.buttonGradient,
                                borderRadius: 6.h,
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  height: 14,
                                  width: 14,
                                  child: SvgPicture.asset(
                                      VehicleWithSpeedLimit.loadSpeedLimits()
                                          .values
                                          .toList()[stateSetting.vehicle]
                                          .path),
                                ),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    body: TextUtils.checkScrollView(
                      orientation == Orientation.portrait,
                      TextUtils.checkRotate(
                        orientation == Orientation.landscape,
                        [
                          BlocBuilder<ThemeCubit, int>(
                            builder: (context, state) {
                              final theme = ThemeOdometer.fromValue(state);
                              final SpeedType speedType =
                                  SpeedType.value(stateSetting.vehicle);
                              switch (theme) {
                                case ThemeOdometer.theme0:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return ThemeBasic(
                                        pathImage: Assets
                                            .images.odometer.theme0.theme0.path,
                                        maxSpeed: 160,
                                      );
                                    case SpeedType.hight:
                                      return ThemeBasic(
                                        pathImage: Assets
                                            .images.odometer.theme0.theme0.path,
                                        maxSpeed: 480,
                                      );
                                    case SpeedType.medium:
                                      return ThemeBasic(
                                        pathImage: Assets
                                            .images.odometer.theme0.theme0.path,
                                        maxSpeed: 2400,
                                      );
                                  }
                                case ThemeOdometer.theme1:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return Theme1(
                                        pathImage: Assets.images.odometer.theme1
                                            .theme160.path,
                                        maxSpeed: 160,
                                      );
                                    case SpeedType.hight:
                                      return Theme1(
                                        pathImage: Assets.images.odometer.theme1
                                            .theme2400.path,
                                        maxSpeed: 2400,
                                      );
                                    case SpeedType.medium:
                                      return Theme1(
                                        pathImage: Assets.images.odometer.theme1
                                            .theme480.path,
                                        maxSpeed: 480,
                                      );
                                  }
                                case ThemeOdometer.theme2:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return Theme2(
                                          pathImage: Assets.images.odometer
                                              .theme2.theme160.path,
                                          maxSpeed: 160);
                                    case SpeedType.hight:
                                      return Theme2(
                                          pathImage: Assets.images.odometer
                                              .theme2.theme2400.path,
                                          maxSpeed: 2400);
                                    case SpeedType.medium:
                                      return Theme2(
                                          pathImage: Assets.images.odometer
                                              .theme2.theme480.path,
                                          maxSpeed: 480);
                                  }

                                case ThemeOdometer.theme4:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return Theme4(
                                          pathImage: Assets.images.odometer
                                              .theme4.theme160.path,
                                          maxSpeed: 160);
                                    case SpeedType.hight:
                                      return Theme4(
                                          pathImage: Assets.images.odometer
                                              .theme4.theme2400.path,
                                          maxSpeed: 2400);
                                    case SpeedType.medium:
                                      return Theme4(
                                          pathImage: Assets.images.odometer
                                              .theme4.theme480.path,
                                          maxSpeed: 480);
                                  }
                                case ThemeOdometer.theme5:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return Theme5(
                                          pathImage: Assets.images.odometer
                                              .theme5.theme160.path,
                                          maxSpeed: 160);
                                    case SpeedType.hight:
                                      return Theme5(
                                          pathImage: Assets.images.odometer
                                              .theme5.theme2400.path,
                                          maxSpeed: 2400);
                                    case SpeedType.medium:
                                      return Theme5(
                                          pathImage: Assets.images.odometer
                                              .theme5.theme480.path,
                                          maxSpeed: 480);
                                  }
                                case ThemeOdometer.theme6:
                                  switch (speedType) {
                                    case SpeedType.low:
                                      return Theme6(
                                          pathImage: Assets.images.odometer
                                              .theme6.theme160.path,
                                          maxSpeed: 160);
                                    case SpeedType.hight:
                                      return Theme6(
                                          pathImage: Assets.images.odometer
                                              .theme6.theme2400.path,
                                          maxSpeed: 2400);
                                    case SpeedType.medium:
                                      return Theme6(
                                          pathImage: Assets.images.odometer
                                              .theme6.theme480.path,
                                          maxSpeed: 480);
                                  }
                              }
                            },
                          ),
                          TextUtils.checkExpanded(
                            orientation == Orientation.landscape,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: permissionNotifier,
                                  builder: (context, value, child) {
                                    return ActionControl(
                                      isActivity: value,
                                      onTap: () async {
                                        await checkPassLocation();
                                      },
                                    );
                                  },
                                ),

                                24.verticalSpace,
                                RowRunTimeOmeter(orient: orientation),
                                24.verticalSpace,
                                // orientation == Orientation.portrait ? 130.verticalSpace: SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void updateStatePermission(bool value) {
    permissionNotifier.value = value;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final status = await checkPermissionLocation();
      if (status && mounted) {
        updateStatePermission(true);
      } else if (!status && mounted) {
        final requestLocation = await requestPermissionLocation();
        if (requestLocation) {
          updateStatePermission(true);
        } else {
          updateStatePermission(false);
        }
      }
    }
  }

  Future<void> checkPassLocation() async {
    PermissionStatus status = PermissionStatus.permanentlyDenied;
    if (Platform.isIOS) {
      status = await Permission.locationWhenInUse.request();
    } else {
      status = await Permission.locationWhenInUse.status;
    }
    if (status.isGranted) {
      updateStatePermission(true);
    } else {
      final result = await showBottomSheetPermission(
          context, const LocationBottomScreen());
      if (result != null) {
        status = await Permission.locationWhenInUse.status;
        if (status.isGranted) {
          updateStatePermission(true);
        }
      } else {
        updateStatePermission(false);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
