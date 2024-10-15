import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../presentation/odometer/cubit/speed_cubit.dart';
import '../../presentation/setting/bloc/setting_bloc.dart';
import '../../presentation/speed_limit/bloc/speed_limit_bloc.dart';
import '../../presentation/speed_limit/widgets/item_textfield_validate_widget.dart';
import '../../utils/style_utils.dart';
import '../../utils/text_utils.dart';
import '../../widgets/dialog/dialog_widget.dart';
import '../../widgets/grid_view_widget.dart';
import '../constants/app_colors.dart';
import '../cubit/hide_navigation_bar_cubit.dart';
import '../extension/context_extension.dart';
import '../mixin/permission_mixin.dart';
import 'cubit/bottom_tab_cubit.dart';

part 'widget/navigation_bar.dart';

@RoutePage()
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen>
    with AutoRouteAwareStateMixin {
  late TextEditingController controller;
  late int count;
  late ItemSpeed itemSpeed;
  late ValueNotifier<bool> valueNotifier;

  @override
  void initState() {
    super.initState();
    TextUtils.settingSystemUI();
    createVehicle();
    //_showRate();
  }

  Future<void> createVehicle() async {
    final isFirstVehicle = await PreferenceManager.getIsFirstVehicle();
    if (isFirstVehicle) {
      controller = TextEditingController();
      count = 0;
      itemSpeed = VehicleWithSpeedLimit.walking.value;
      valueNotifier = ValueNotifier(true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSpeedLimit(
          context: context,
          controller: controller,
          count: count,
          itemSpeed: itemSpeed,
          valueNotifier: valueNotifier,
        );
      });
      PreferenceManager.saveIsFirstVehicle(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: [
        HudRoute(),
        SpeedometerRoute(),
        SettingRoute(),
      ],
      physics: NeverScrollableScrollPhysics(),
      builder: (context, child, pageController) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Stack(
                children: [
                  child,
                  IgnorePointer(
                    child: BlocBuilder<SpeedCubit, SpeedState>(
                      bloc: getIt<SpeedCubit>(),
                      builder: (context, state) {
                        String imagePath;
                        switch (state.speedWarning) {
                          case SpeedWarning.red:
                            imagePath = Assets.images.errorRed.path;
                            break;
                          case SpeedWarning.orange:
                            imagePath = Assets.images.errorOrange.path;
                            break;
                          case SpeedWarning.none:
                            return const SizedBox.shrink();
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                  IgnorePointer(
                    child: BlocBuilder<SpeedCubit, SpeedState>(
                      bloc: getIt<SpeedCubit>(),
                      builder: (context, state) {
                        String imagePath;
                        switch (state.speedWarning) {
                          case SpeedWarning.red:
                            imagePath = Assets.images.errorRed.path;
                            break;
                          case SpeedWarning.orange:
                            imagePath = Assets.images.errorOrange.path;
                            break;
                          case SpeedWarning.none:
                            return const SizedBox.shrink();
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Transform.flip(
                            flipY: true,
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BlocListener<BottomTabCubit, int>(
                  listener: (context, state) {
                    if (state != -1) {
                      tabsRouter.setActiveIndex(state);
                    }
                  },
                  child: BlocBuilder<HideNavigationBarCubit, bool>(
                    builder: (contextVisible, stateVisible) {
                      return Visibility(
                        visible: stateVisible,
                        child: BlocBuilder<BottomTabCubit, int>(
                          builder: (context, state) {
                            return MainNavigationBar(
                              activeIndex: tabsRouter.activeIndex,
                              onTabChange: (int index) async {
                                context.read<BottomTabCubit>().changeTab(index);
                                //logger.e("m co chay ko: ${index}");
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> showSpeedLimit({
    required BuildContext context,
    required TextEditingController controller,
    required int count,
    required ItemSpeed itemSpeed,
    required ValueNotifier<bool> valueNotifier,
  }) async {
    controller.text = itemSpeed.speed.toString();
    final Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits =
        await PreferenceManager.getSpeedLimits();
    final speedLimitList = allSpeedLimits.entries.toList();
    final ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(0);
    //if (await PreferenceManager.getCountPermission() == 1 && context.mounted) {
    DialogWidget.showDialogWidget(
      padding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 16.h),
      context: context,
      title: context.l10n.vehicle,
      contentWidget: Column(
        children: [
          GridViewWidget(
            onTap: (index, value) async {
              count = index;
              itemSpeed = value;
              controller.text = value.speed.toString();
              valueNotifier.value = true;
            },
            items: VehicleWithSpeedLimit.loadSpeedLimits().values.toList(),
            selectedIndex: selectedIndex,
          ),
          ItemTextFieldValidateWidget(controller: controller),
          ValueListenableBuilder<bool>(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              if (!value) {
                return BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: context.l10n.validate,
                              style: StyleUtils.style.regular.textRed.s16),
                          TextSpan(
                            text: ' 0 - ',
                            style: StyleUtils.style.regular.textRed.s16
                                .copyWith(
                                    fontFamily: state.fontType == 0
                                        ? FontFamily.sfpro
                                        : FontFamily.dsdigi,
                                    fontSize: state.fontType == 0 ? 16 : 16.5),
                          ),
                          TextSpan(
                            text: '${itemSpeed.speedLimit}',
                            style: StyleUtils.style.regular.textRed.s16
                                .copyWith(
                                    fontFamily: state.fontType == 0
                                        ? FontFamily.sfpro
                                        : FontFamily.dsdigi,
                                    fontSize: state.fontType == 0 ? 16 : 16.5),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      onConfirm: () {
        final int? speed = double.tryParse(controller.text)?.toInt();
        if (speed != null && speed > 0) {
          valueNotifier.value = speed <= itemSpeed.speedLimit;
          if (valueNotifier.value) {
            final updatedItem =
                speedLimitList[count].value.copyWith(speed: speed);
            allSpeedLimits[speedLimitList[count].key] = updatedItem;
            PreferenceManager.setSpeedLimits(allSpeedLimits);
            PreferenceManager.setVehicle(count);
            context.maybePop();
          }
        } else {
          valueNotifier.value = false;
        }
      },
    );
    //}
  }
}
