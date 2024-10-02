import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/weather/weather.dart';
import '../../../service/api_service.dart';
import '../repository/weather_repository.dart';

class WeatherCubit extends HydratedCubit<Weather> {
  WeatherCubit() : super(Weather());

  final WeatherRepository _weatherRepository = WeatherRepository();

  Future<void> fetchAndStoreWeather(WeatherParams params) async {
    try {
      final weather = await _weatherRepository.getWeather(params);

      emit(weather);
    } catch (e) {
      throw Exception(e);
    }
  }

  bool shouldFetchWeather() {
    final lastUpdatedStr = state.current?.lastUpdated;

    if (lastUpdatedStr == null) {
      return true;
    }

    final DateTime lastUpdated =
        DateFormat('yyyy-MM-dd HH:mm').parse(lastUpdatedStr);

    final DateTime now = DateTime.now();

    final DateTime today = DateTime(now.year, now.month, now.day);

    return lastUpdated.isBefore(today);
  }

  @override
  Weather? fromJson(Map<String, dynamic> json) {
    return Weather.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Weather state) {
    return state.toJson();
  }
}
