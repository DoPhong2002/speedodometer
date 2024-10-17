import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import '../data/local/shared_preferences_manager.dart';

@injectable
class LocationService {
  LocationService(this.preferenceManager);

  final PreferenceManager preferenceManager;

  Location get _location => Location();

  Future<LatLng> getCurrentLocation() async {
    final LocationData position = await _location.getLocation();
    final double lat = position.latitude ?? 0;
    final double long = position.longitude ?? 0;
    return LatLng(lat, long);
  }
}
