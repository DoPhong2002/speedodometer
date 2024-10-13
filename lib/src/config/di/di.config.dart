// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:odometer/src/config/navigation/app_router.dart' as _i440;
import 'package:odometer/src/data/local/shared_preferences_manager.dart'
    as _i185;
import 'package:odometer/src/presentation/language/cubit/language_cubit.dart'
    as _i667;
import 'package:odometer/src/presentation/map/cubit/speed_cubit.dart' as _i289;
import 'package:odometer/src/presentation/map/cubit/timer_cubit.dart' as _i36;
import 'package:odometer/src/presentation/setting/bloc/setting_bloc.dart'
    as _i546;
import 'package:odometer/src/presentation/setting/compass/cubit/compass_cubit.dart'
    as _i1036;
import 'package:odometer/src/presentation/setting/theme/cubit/theme_cubit.dart'
    as _i711;
import 'package:odometer/src/presentation/speed_limit/bloc/speed_limit_bloc.dart'
    as _i154;
import 'package:odometer/src/service/location_service.dart' as _i820;
import 'package:odometer/src/shared/cubit/hide_navigation_bar_cubit.dart'
    as _i474;
import 'package:odometer/src/shared/screen/cubit/bottom_tab_cubit.dart' as _i93;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i185.PreferenceManager>(() => _i185.PreferenceManager());
    gh.factory<_i36.Ticker>(() => const _i36.Ticker());
    gh.singleton<_i440.AppRouter>(() => _i440.AppRouter());
    gh.singleton<_i667.LanguageCubit>(() => _i667.LanguageCubit());
    gh.singleton<_i289.SpeedCubit>(() => _i289.SpeedCubit());
    gh.singleton<_i546.SettingBloc>(() => _i546.SettingBloc());
    gh.singleton<_i1036.CompassCubit>(() => _i1036.CompassCubit());
    gh.singleton<_i711.ThemeCubit>(() => _i711.ThemeCubit());
    gh.singleton<_i154.SpeedLimitBloc>(() => _i154.SpeedLimitBloc());
    gh.singleton<_i474.HideNavigationBarCubit>(
        () => _i474.HideNavigationBarCubit());
    gh.singleton<_i93.BottomTabCubit>(() => _i93.BottomTabCubit());
    gh.factory<_i820.LocationService>(
        () => _i820.LocationService(gh<_i185.PreferenceManager>()));
    gh.singleton<_i36.TimerBloc>(() => _i36.TimerBloc(gh<_i36.Ticker>()));
    return this;
  }
}
