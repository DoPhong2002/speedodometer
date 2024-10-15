import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import '../src/config/di/di.dart';
import '../src/config/navigation/app_router.dart';
import '../src/config/observer/route_observer.dart';
import '../src/config/theme/light/light_theme.dart';
import '../src/presentation/map/cubit/speed_cubit.dart';
import '../src/presentation/map/cubit/timer_cubit.dart';
import '../src/presentation/setting/bloc/setting_bloc.dart';
import '../src/presentation/setting/compass/cubit/compass_cubit.dart';
import '../src/presentation/setting/theme/cubit/theme_cubit.dart';
import '../src/presentation/speed_limit/bloc/speed_limit_bloc.dart';
import '../src/presentation/weather/cubits/weather_cubit.dart';
import '../src/shared/cubit/hide_navigation_bar_cubit.dart';
import '../src/shared/enum/language.dart';
import '../src/shared/screen/cubit/bottom_tab_cubit.dart';
import '../src/widgets/dialog/no_internet_dialog.dart';
import '../src/presentation/language/cubit/language_cubit.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double get designWidth => 360; //default
  double get designHeight => 800; //default
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => getIt<BottomTabCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HideNavigationBarCubit>(),
        ),
        BlocProvider(
          create: (context) =>getIt<SettingBloc>()..add(const SettingInitEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<SpeedCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TimerBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SpeedLimitBloc>(),
        ),
        BlocProvider(
          create: (_) => WeatherCubit(),
        ),
        BlocProvider(
          create: (_) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CompassCubit>(),
        )

      ],
      child: ScreenUtilInit(
        designSize: Size(designWidth, designHeight),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, child) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const BodyApp(),
        ),
      ),
    );
  }
}

class BodyApp extends StatefulWidget {
  const BodyApp({
    super.key,
  });

  @override
  State<BodyApp> createState() => _BodyAppState();
}

class _BodyAppState extends State<BodyApp> {
  bool shownDialog = false;
  StreamSubscription? internetListener;

  Future<void> listenInternet() async {
    internetListener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) async {
      switch (status) {
        case InternetConnectionStatus.connected:

          if (shownDialog) {
            shownDialog = false;
            getIt<AppRouter>().navigatorKey.currentContext!.maybePop();
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (!shownDialog) {
            shownDialog = true;
            showNoInternetDialog();
          }
          break;
      }
      await Future.delayed(const Duration(seconds: 3));
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      listenInternet();
    });
    super.initState();
  }

  @override
  void dispose() {
    internetListener?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      builder: (context, state) => OverlaySupport.global(
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.languageCode),
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          routerConfig: getIt<AppRouter>().config(
            navigatorObservers: () => [MainRouteObserver()],
          ),
        ),
      ),
    );
  }
}
