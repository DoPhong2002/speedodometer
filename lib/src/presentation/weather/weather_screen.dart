import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../language/cubit/language_cubit.dart';
import '../../config/di/di.dart';
import '../../data/models/weather/weather.dart';
import '../../gen/assets.gen.dart';
import '../../service/api_service.dart';
import '../../service/location_service.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/helpers/logger_utils.dart';
import '../../shared/mixin/permission_mixin.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../utils/time_utlil.dart';
import '../../widgets/gps_background.dart';
import 'cubits/weather_cubit.dart';
import 'widgets/center_weather_widget.dart';
import 'widgets/item_summary_widget.dart';
import 'widgets/weather_detail_widget.dart';

@RoutePage()
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with PermissionMixin, WidgetsBindingObserver {
  final ValueNotifier<bool> btnNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> temperatureNotifier = ValueNotifier<int>(0);
  bool _processInResume = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (_processInResume) {
        final status = await checkPermissionLocation();
        if (status && mounted) {
          await _fetchWeather();
        } else {
          final requestLocation = await requestPermissionLocation();
          if (requestLocation) {
            await _fetchWeather();
          }
        }
      }
      setState(() {
        _processInResume = false;
      });
    }
  }

  Future<void> _checkPermission() async {
    final status = await checkPermissionLocationStatus();
    if (status.isGranted) {
      _fetchWeather();
    } else if (status.isPermanentlyDenied) {
      setState(() {
        _processInResume = true;
      });
      await showDialogGoToSetting(
          title: context.l10n.requestLocationPermission,
          content: context.l10n.pleaseGrantLocationPermission,
          image: Assets.icons.permission.icLocationPermission.path,
          callback: () {
            setState(() {
              _processInResume = false;
            });
          });
    } else {
      final statusLocation = await Permission.locationWhenInUse.request();
      if (statusLocation.isGranted) {
        _fetchWeather();
      }
    }
  }

  Future<void> _fetchWeather() async {
    final weatherCubit = context.read<WeatherCubit>();
    final locationService = getIt<LocationService>();
    final lang = context.read<LanguageCubit>().state.languageCode;

    if (!weatherCubit.shouldFetchWeather()) {
      return;
    }

    try {
      final location = await locationService.getCurrentLocation();
      await weatherCubit.fetchAndStoreWeather(
        WeatherParams(
          curLocation: '${location.latitude},${location.longitude}',
          lang: lang,
        ),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GpsAppbar(
            context,
            context.l10n.weather,
            heightAppBar: orientation == Orientation.landscape ? 40 : 80,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CenterWeatherWidget(),
                BlocBuilder<WeatherCubit, Weather>(
                  bloc: context.read<WeatherCubit>(),
                  builder: (context, state) {
                    return WeatherDetailWidget(
                      city: state.location?.name ?? context.l10n.city,
                      range:
                          'H: ${state.forecast?.forecastday?[0].day?.maxtempC?.round() ?? '0'}° '
                          '- L: ${state.forecast?.forecastday?[0].day?.mintempC?.round() ?? '0'}°',
                      time: DateTime.now().toString().convertTohhmmaEEEEdMMM(),
                    );
                  },
                ),
                24.verticalSpace,
                const ItemSummaryWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }

  bool isNotAfterNow(String timeStr) {
    final DateTime now = DateTime.now();

    if (timeStr.isEmpty || !timeStr.contains(':')) {
      return false;
    }
    final List<String> timeParts = timeStr.split(':');
    final int inputHour = int.parse(timeParts[0]);
    final int nowHour = now.hour;
    final int inputMinute = int.parse(timeParts[1]);

    final DateTime inputTime =
        DateTime(now.year, now.month, now.day, inputHour, inputMinute);

    return now.isAfter(inputTime) && nowHour != inputHour;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
