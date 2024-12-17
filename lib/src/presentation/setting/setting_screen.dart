import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odometer/src/data/local/secure_storage_manager.dart';
import '../language/cubit/language_cubit.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../shared/cubit/value_cubit.dart';
import '../../shared/enum/language.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../utils/style_utils.dart';
import '../../widgets/dialog/dialog_widget.dart';
import '../../widgets/gps_background.dart';
import '../../widgets/grid_view_widget.dart';
import '../../widgets/item_list/check_box_select_item.dart';
import '../../widgets/item_list/item_list_or_switch_widget.dart';
import '../speed_limit/bloc/speed_limit_bloc.dart';
import 'bloc/setting_bloc.dart';

@RoutePage()
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    _initCubit();
    super.initState();
  }

  void _initCubit() {
    final unit = getIt<SettingBloc>().state.speedUnit;
    unitCubit = ValueCubit(unit == 'Mp/h'
        ? Unit.mi
        : unit == 'Nmi'
            ? Unit.nmi
            : Unit.km);

    fontCubit = ValueCubit(
      getIt<SettingBloc>().state.fontType == 0
          ? FontStyle.normal
          : FontStyle.digital,
    );
  }

  bool isSharing = false;
  ValueNotifier<bool> rotateSwitchValue = ValueNotifier<bool>(false);
  late final ValueCubit<Unit> unitCubit;
  late final ValueCubit<FontStyle> fontCubit;

  @override
  Widget build(BuildContext context) {
    return GpsBackgroundHome(
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GpsAppbar(
            context,
            context.l10n.setting,
            leadingWid: 0,
            titleCenter: true,
            automaticallyLeading: true,
            heightAppBar: orientation == Orientation.landscape ? 40 : 80,
          ),
          body: BlocBuilder<SettingBloc, SettingState>(
            builder: (bloc, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          context.l10n.general,
                          style: StyleUtils.style.white.medium.s16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ItemListOrSwitchWidget(
                        title: context.l10n.speed_limit,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.speedLimit.svg(),
                        onTapItem: () {
                          context.pushRoute(const SpeedLimitRoute());
                          // SecureStorageManager().testEncryption();
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.speed_unit,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.speedUnit.svg(),
                        textRight: state.speedUnit,
                        onTapItem: () {
                          unitCubit.update(Unit.values[state.indexUnit]);
                          DialogWidget.showDialogWidget(
                            context: context,
                            title: context.l10n.speed_unit,
                            contentWidget: widgetSpeedUnit(isSpeed: true),
                            onConfirm: () {
                              context.maybePop();
                              getIt<SettingBloc>()
                                  .add(SpeedUnitEvent(unitCubit.state));
                            },
                          );
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.vehicle,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.vehicle.svg(),
                        textRight: VehicleWithSpeedLimit.loadSpeedLimits()
                            .values
                            .toList()[state.vehicle]
                            .title,
                        onTapItem: () {
                          final ValueNotifier<int?> selectedIndex =
                              ValueNotifier<int?>(state.vehicle);
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
                            onConfirm: () {
                              bloc
                                  .read<SettingBloc>()
                                  .add(VehicleEvent(selectedIndex.value ?? 0));
                              context.maybePop();
                            },
                          );
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.distance_unit,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.distanceUnit.svg(),
                        textRight: state.distanceUnit,
                        onTapItem: () {
                          unitCubit.update(Unit.values[state.indexUnit]);
                          DialogWidget.showDialogWidget(
                            context: context,
                            title: context.l10n.distance_unit,
                            contentWidget: widgetSpeedUnit(),
                            onConfirm: () {
                              context.maybePop();
                              getIt<SettingBloc>()
                                  .add(SpeedUnitEvent(unitCubit.state));
                            },
                          );
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.font_type,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.fontType.svg(),
                        textRight: state.fontType == 0
                            ? context.l10n.normal
                            : context.l10n.digital,
                        onTapItem: () {
                          fontCubit.update(FontStyle.values[state.fontType]);
                          DialogWidget.showDialogWidget(
                            context: context,
                            title: context.l10n.font_type,
                            contentWidget: widgetFontType(),
                            onConfirm: () {
                              context.maybePop();
                              bloc
                                  .read<SettingBloc>()
                                  .add(FontTypeEvent(fontCubit.state));
                            },
                          );
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.compass,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.compass.svg(),
                        onTapItem: () {
                          context.pushRoute(const CompassRoute());
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.odometer_theme,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.odometer.svg(),
                        onTapItem: () {
                          context.pushRoute(const ThemeRoute());
                        },
                      ),
                      ItemListOrSwitchWidget(
                        title: context.l10n.weather,
                        rightWidget: Assets.icons.settings.nextSetting.svg(),
                        iconLeft: Assets.icons.settings.weather.svg(),
                        onTapItem: () {
                          if (context.mounted) {
                            context.pushRoute(const WeatherRoute());
                          }
                        },
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        bloc: getIt<SettingBloc>(),
                        builder: (context, state) {
                          rotateSwitchValue.value = state.rotate;

                          return ItemListOrSwitchWidget(
                            title: context.l10n.rotate,
                            onChangedSwitch: (value) {
                              bloc.read<SettingBloc>().add(RotateEvent(value));
                              if (value) {
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight,
                                ]);
                              } else {
                                SystemChrome
                                    .setPreferredOrientations(<DeviceOrientation>[
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                              }
                            },
                            valueNotifier: rotateSwitchValue,
                            iconLeft: Assets.icons.settings.rotate.svg(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(context.l10n.other,
                          style: StyleUtils.style.white.medium.s16),
                      const SizedBox(height: 24),
                      BlocBuilder<LanguageCubit, Language>(
                        bloc: getIt<LanguageCubit>(),
                        builder: (context, state) {
                          return ItemListOrSwitchWidget(
                            title: context.l10n.language,
                            rightWidget:
                                Assets.icons.settings.nextSetting.svg(),
                            iconLeft: Assets.icons.settings.language.svg(),
                            textRight: state.languageName,
                            onTapItem: () async {
                              context.pushRoute(LanguageRoute());
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget widgetSpeedUnit({bool isSpeed = false, int indexUnit = 0}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Unit.values.length,
      itemBuilder: (context, index) {
        return BlocBuilder<ValueCubit<Unit>, Unit>(
          bloc: unitCubit,
          builder: (context, state) {
            return CheckBoxSelectItem<Unit>(
              title: isSpeed
                  ? Unit.values[index].speedUnit
                  : Unit.values[index].distanceUnit,
              value: Unit.values[index],
              selectedValue: state,
              onTap: () {
                unitCubit.update(Unit.values[index]);
              },
            );
          },
        );
      },
    );
  }

  Widget widgetFontType() {
    return BlocBuilder<ValueCubit<FontStyle>, FontStyle>(
      bloc: fontCubit,
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: FontStyle.values.length,
          itemBuilder: (context, index) {
            final style = index == 0
                ? StyleUtils.style.white.regular.s16
                : StyleUtils.style.white.regular.s16
                    .copyWith(fontFamily: FontFamily.dsdigi);
            return CheckBoxSelectItem(
              title: FontStyle.values[index].font(context),
              textRight: '123',
              styleTextRight: style,
              value: FontStyle.values[index],
              selectedValue: state,
              onTap: () {
                fontCubit.update(FontStyle.values[index]);
              },
            );
          },
        );
      },
    );
  }
}
