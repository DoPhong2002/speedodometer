// const openWeatherAPIKey = 'e74c9409debb436690f84137240108';
const openWeatherAPIKey = '8558c7f392aa479f8b1132327241610';
class WeatherParams {
  WeatherParams({
    required this.curLocation,
    this.day,
    this.lang,
  });

  final String curLocation;
  final int? day;
  final String? lang;
}

class WeatherApiService {
  WeatherApiService(this.apiKey);

  final String apiKey;

  static const String _apiBaseUrl = 'api.weatherapi.com';
  static const String _endPoint = '/v1/forecast.json';

  Map<String, String> _queryParameters(WeatherParams params) => {
        'q': params.curLocation,
        'key': apiKey,
        'days': (params.day ?? 1).toString(), // 1 to 14
        'lang': params.lang ?? 'en',
      };

  Uri _buildUri({
    required String endpoint,
    required Map<String, String> Function() parametersBuilder,
  }) {
    return Uri.https(
      _apiBaseUrl,
      endpoint,
      parametersBuilder(),
    );
  }

  Uri getWeatherUri(WeatherParams params) {
    return _buildUri(
      endpoint: _endPoint,
      parametersBuilder: () => _queryParameters(params),
    );
  }
}