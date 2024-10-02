import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/speed_limit/bloc/speed_limit_bloc.dart';
import '../../shared/enum/preference_keys.dart';

@injectable
class PreferenceManager {
  Future<SharedPreferences> get _preference => SharedPreferences.getInstance();

  Future<String?> getString(String key) async {
    return (await _preference).getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return (await _preference).setString(key, value);
  }

  Future<bool> remove(String key) async {
    return (await _preference).remove(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return (await _preference).setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return (await _preference).getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return (await _preference).setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return (await _preference).getInt(key);
  }

  static Future<void> saveIsFirstLaunch(bool status) async {
    (await SharedPreferences.getInstance())
        .setBool(PreferenceKeys.isFirstLaunch.name, status);
  }

  static Future<bool> getIsFirstLaunch() async {
    return (await SharedPreferences.getInstance())
            .getBool(PreferenceKeys.isFirstLaunch.name) ??
        true;
  }

  static Future<void> saveIsFirstPermission(bool status) async {
    (await SharedPreferences.getInstance())
        .setBool(PreferenceKeys.isFirstPermission.name, status);
  }

  static Future<bool> getIsFirstPermission() async {
    return (await SharedPreferences.getInstance())
            .getBool(PreferenceKeys.isFirstPermission.name) ??
        true;
  }

  static Future<void> saveIsFirstVehicle(bool status) async {
    (await SharedPreferences.getInstance())
        .setBool(PreferenceKeys.isFirstVehicle.name, status);
  }

  static Future<bool> getIsFirstVehicle() async {
    return (await SharedPreferences.getInstance())
        .getBool(PreferenceKeys.isFirstVehicle.name) ??
        true;
  }

  static Future<void> saveIsFirstPremium(bool status) async {
    (await SharedPreferences.getInstance())
        .setBool(PreferenceKeys.isFirstPremium.name, status);
  }

  static Future<bool> getIsFirstPremium() async {
    return (await SharedPreferences.getInstance())
            .getBool(PreferenceKeys.isFirstPremium.name) ??
        true;
  }

  static Future<void> setIsPremium(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.isPremium.name, status);
  }

  static Future<bool> getIsPremium() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isPremium.name) ?? false;
  }

  static Future<void> setIsWeeklyPremium(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.isWeeklyPremium.name, status);
  }

  static Future<bool> getIsWeeklyPremium() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isWeeklyPremium.name) ?? false;
  }

  static Future<void> setIsMonthlyPremium(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.isMonthlyPremium.name, status);
  }

  static Future<bool> getIsMonthlyPremium() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.isMonthlyPremium.name) ?? false;
  }

  static Future<void> setSpeedUnit(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.speedUnit.name, value);
  }

  static Future<String> getSpeedUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.speedUnit.name) ?? 'Km/h';
  }

  static Future<void> setDistanceUnit(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.distanceUnit.name, value);
  }

  static Future<String> getDistanceUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.distanceUnit.name) ?? 'Km';
  }

  static Future<void> setFontType(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PreferenceKeys.fontType.name, value);
  }

  static Future<int> getFontType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PreferenceKeys.fontType.name) ?? 0;
  }

  static Future<void> setVehicle(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PreferenceKeys.vehicle.name, value);
  }

  static Future<int> getVehicle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PreferenceKeys.vehicle.name) ?? 0;
  }

  static Future<void> setRotate(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceKeys.rotate.name, status);
  }

  static Future<bool> getRotate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PreferenceKeys.rotate.name) ?? false;
  }

  static Future<void> setSpeedMax(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(PreferenceKeys.speedMax.name, value);
  }

  static Future<double> getSpeedMax() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(PreferenceKeys.speedMax.name) ?? 0;
  }

  static Future<void> increasePermissionCount() async {
    final int count = (await getCountPermission()) + 1;
    (await SharedPreferences.getInstance())
        .setInt(PreferenceKeys.countPermission.name, count);
  }

  static Future<int> getCountPermission() async {
    return (await SharedPreferences.getInstance())
            .getInt(PreferenceKeys.countPermission.name) ??
        0;
  }

  static Future<void> setThemeOdometer(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferenceKeys.themeOdometer.name, value);
  }

  static Future<int> getThemeOdometer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PreferenceKeys.themeOdometer.name) ?? 0;
  }

  static Future<void> setSpeedLimits(
      Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> jsonMap = allSpeedLimits.map((key, value) {
      return MapEntry(key.toString(), value.toJson());
    });

    final jsonString = jsonEncode(jsonMap);

    await prefs.setString(PreferenceKeys.speedLimit.name, jsonString);
  }

  static Future<Map<VehicleWithSpeedLimit, ItemSpeed>> getSpeedLimits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(PreferenceKeys.speedLimit.name);

    if (jsonString != null ) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits = jsonMap.map((key, value) {
        final speedLimit = VehicleWithSpeedLimit.values.firstWhere((e) => e.toString() == key);
        return MapEntry(speedLimit, ItemSpeed.fromJson(value));
      });

      return allSpeedLimits;
    } else {
      return VehicleWithSpeedLimit.loadSpeedLimits();
    }
  }

  static Future<void> setLat(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(PreferenceKeys.lat.name, value);
  }

  static Future<double> getLat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(PreferenceKeys.lat.name) ?? 21.038412;
  }

  static Future<void> setLong(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(PreferenceKeys.long.name, value);
  }

  static Future<double> getLong() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(PreferenceKeys.long.name) ?? 105.780716;
  }

  static Future<void> saveLatLng(LatLng latLng) async {
    final prefs = await SharedPreferences.getInstance();
    final latLngJson = jsonEncode({
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    });
    await prefs.setString(PreferenceKeys.latLong.name, latLngJson);
  }

  static Future<LatLng> getLatLng() async {
    final prefs = await SharedPreferences.getInstance();
    final latLngJson = prefs.getString(PreferenceKeys.latLong.name);

    if (latLngJson != null) {
      final latLongMap = jsonDecode(latLngJson);
      return LatLng(
        latLongMap['latitude'],
        latLongMap['longitude'],
      );
    }
    return const LatLng(0, 0);
  }

}
