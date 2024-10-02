class WeatherInfo {
  WeatherInfo({
    required this.temperature,
    required this.condition,
    required this.cityName,
  });

  final double temperature;
  final WeatherCondition condition;
  final String cityName;
}

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  snowy,
  windy;

  String get value {
    switch (this) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.snowy:
        return 'Snowy';
      case WeatherCondition.windy:
        return 'Windy';
    }
  }
}
