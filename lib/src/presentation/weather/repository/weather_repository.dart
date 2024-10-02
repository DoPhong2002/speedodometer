import 'dart:convert';

import "package:http/http.dart" as http;

import '../../../data/models/weather/weather.dart';
import '../../../service/api_service.dart';

class WeatherRepository {
  WeatherRepository();

  final WeatherApiService apiService =
      WeatherApiService(APIKeys.openWeatherAPIKey);

  final http.Client client = http.Client();

  Future<Weather> getWeather(WeatherParams params) async {
    try {
      final Uri uri = apiService.getWeatherUri(params);
      final http.Response response = await client.get(uri);

      return Weather.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
