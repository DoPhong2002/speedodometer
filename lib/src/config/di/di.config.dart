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
import 'package:odometer/src/data/local/secure_storage_manager.dart' as _i245;
import 'package:odometer/src/data/local/shared_preferences_manager.dart'
    as _i185;
import 'package:odometer/src/presentation/language/cubit/language_cubit.dart'
    as _i667;
import 'package:odometer/src/presentation/odometer/cubit/speed_cubit.dart'
    as _i8;
import 'package:odometer/src/presentation/odometer/cubit/timer_cubit.dart'
    as _i611;
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
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.factory<_i245.SecureStorageManager>(() => _i245.SecureStorageManager());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i611.Ticker>(() => const _i611.Ticker());
    gh.singleton<_i440.AppRouter>(() => _i440.AppRouter());
    gh.singleton<_i667.LanguageCubit>(() => _i667.LanguageCubit());
    gh.singleton<_i8.SpeedCubit>(() => _i8.SpeedCubit());
    gh.singleton<_i546.SettingBloc>(() => _i546.SettingBloc());
    gh.singleton<_i1036.CompassCubit>(() => _i1036.CompassCubit());
    gh.singleton<_i711.ThemeCubit>(() => _i711.ThemeCubit());
    gh.singleton<_i154.SpeedLimitBloc>(() => _i154.SpeedLimitBloc());
    gh.singleton<_i474.HideNavigationBarCubit>(
        () => _i474.HideNavigationBarCubit());
    gh.singleton<_i93.BottomTabCubit>(() => _i93.BottomTabCubit());
    gh.factory<_i185.PreferenceManager>(
        () => _i185.PreferenceManager(gh<_i460.SharedPreferences>()));
    gh.singleton<_i611.TimerBloc>(() => _i611.TimerBloc(gh<_i611.Ticker>()));
    gh.factory<_i820.LocationService>(
        () => _i820.LocationService(gh<_i185.PreferenceManager>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i185.SharedPreferencesModule {}
