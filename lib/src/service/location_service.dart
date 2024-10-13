import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../presentation/language/cubit/language_cubit.dart';
import '../../main.dart';
import '../config/di/di.dart';
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

  Future<String> getCountryCodeFromLocation() async {
    final currentLocation = await getCurrentLocation();
    String countryCode = '';
    try {
      final List<geo.Placemark> placeMarks = await geo.placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      debugPrint(placeMarks.toString());
      debugPrint(placeMarks.first.toString());
      countryCode = placeMarks.first.isoCountryCode ?? '';
    } catch (e) {
      debugPrint(e.toString());
    }
    return countryCode;
  }

  Future<String> getCurrentAddress(LatLng latLng, {int countReload = 0}) async {
    String address = '';
    if (countReload <= 5) {
      final locale = getIt<LanguageCubit>().state.languageCode;
      try {
        geo.setLocaleIdentifier(locale);
        final List<geo.Placemark> placeMarks =
            await geo.placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
          //localeIdentifier: locale,
        );
        if (Platform.isIOS) {
          address = _addressForIos(placeMarks, address);
        } else {
          address = _addressForAndroid(placeMarks, address);
        }
      } on PlatformException catch (_) {
        return getCurrentAddress(latLng, countReload: countReload++);
      } //HoangCV log
/*      Global.instance.user = Global.instance.user?.copyWith(
        address: address,
      );*/
    }

    return address;
  }

  String _addressForAndroid(List<geo.Placemark> placeMarks, String address) {
    try {
      if (placeMarks.isNotEmpty && placeMarks.length >= 3) {
        final String street = _remakeAddress(placeMarks[1].street);
        final String locality = _remakeAddress(placeMarks[3].locality);
        final String subAdministrativeArea =
            _remakeAddress(placeMarks[0].subAdministrativeArea);
        final String administrativeArea =
            _remakeAddress(placeMarks[0].administrativeArea);
        final String country = _remakeAddress(placeMarks[0].country);
        address =
            '$street $locality $subAdministrativeArea $administrativeArea $country';
        return address;
      } else {
        return ' ';
      }
    } catch (_) {
      return ' ';
    }
  }

  String _addressForIos(List<geo.Placemark> placeMarks, String address) {
    final String street = _remakeAddress(placeMarks[0].street);
    final String locality = _remakeAddress(placeMarks[0].subLocality);
    final String subAdministrativeArea =
        _remakeAddress(placeMarks[0].subAdministrativeArea);
    final String administrativeArea =
        _remakeAddress(placeMarks[0].administrativeArea);
    final String country = _remakeAddress(placeMarks[0].country);
    address =
        '$street $locality $subAdministrativeArea $administrativeArea $country';
    return address;
  }

  String _remakeAddress(String? address) {
    if (address != null && address.isNotEmpty) {
      return '$address,';
    }
    return '';
  }

  Stream<LatLng> getLocationStream({
    double? distanceInMeters,
  }) {
    final Location location = Location();
    location.enableBackgroundMode(enable: false);
    location.changeSettings(
      distanceFilter: distanceInMeters ?? 1,
    );
    return location.onLocationChanged.map((LocationData event) =>
        LatLng(event.latitude ?? 0, event.longitude ?? 0));
  }

  Stream<LatLng> getLocationStreamOnBackground() {
    final Location location = Location();
    location.enableBackgroundMode();
    location.changeSettings(interval: 5000, distanceFilter: 10);
    return location.onLocationChanged.map((LocationData event) =>
        LatLng(event.latitude ?? 0, event.longitude ?? 0));
  }

  Future<String> getCurrentAddressWithoutDetail() async {
    final latLng = await getCurrentLocation();
    String address = '';
    final locale = getIt<LanguageCubit>().state.languageCode;
    try {
      geo.setLocaleIdentifier(locale);
      final List<geo.Placemark> placeMarks = await geo.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (Platform.isIOS) {
        address = _addressForIos(placeMarks, address);
      } else {
        address = _addressForAndroid(placeMarks, address);
      }
    } on PlatformException catch (_) {
      return getCurrentAddress(latLng);
    }

    return address;
  }
}
