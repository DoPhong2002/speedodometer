import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/trip/trip_model.dart';
import '../../presentation/hud/hud_screen.dart';
import '../../presentation/language/screen/language_screen.dart';
import '../../presentation/map/map_screen.dart';
import '../../presentation/odometer/speedometer_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/permission/permission_screen.dart';
import '../../presentation/setting/compass/compass_screen.dart';
import '../../presentation/setting/setting_screen.dart';
import '../../presentation/setting/theme/theme_screen.dart';
import '../../presentation/speed_limit/speed_limit_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/weather/weather_screen.dart';
import '../../shared/screen/shell_screen.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LanguageRoute.page),
        AutoRoute(page: OnBoardingRoute.page),
        AutoRoute(page: PermissionRoute.page),
        AutoRoute(page: WeatherRoute.page),
        CustomRoute(
            page: ShellRoute.page,
            transitionsBuilder: TransitionsBuilders.noTransition,
            children: [
              AutoRoute(page: HudRoute.page),
              AutoRoute(page: SpeedometerRoute.page),
              AutoRoute(page: SettingRoute.page),
            ]),
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: CompassRoute.page),
        AutoRoute(page: MapRoute.page),
        AutoRoute(page: ThemeRoute.page),
        AutoRoute(page: SpeedLimitRoute.page),
      ];

  AutoRoute routeWithFadeTransition(
      {required PageInfo<void> page, bool initial = false}) {
    return CustomRoute(
      page: page,
      initial: initial,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
