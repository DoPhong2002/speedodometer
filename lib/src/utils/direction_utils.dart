extension DirectionUtils on double {
  String get getDirection {
    const List<String> directions = [
      'N',
      'NE',
      'E',
      'SE',
      'S',
      'SW',
      'W',
      'NW'
    ];

    // Normalize the direction to a value between 0 and 360
    final normalizedDirection = this % 360;

    // Calculate the index based on 45-degree intervals (360 degrees / 8 directions)
    final index = ((normalizedDirection + 22.5) / 45).floor() % 8;

    return directions[index];
  }
}
