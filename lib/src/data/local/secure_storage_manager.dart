import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/speed_limit/bloc/speed_limit_bloc.dart';
import 'encrypt_manager.dart';

/// Enum để quản lý các key
enum SecureStorageKey { secureLimitSpeed }

@injectable
class SecureStorageManager {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final EncryptManager _encryptManager = EncryptManager();
  FlutterSecureStorage get storage => _secureStorage;

  /// Chuyển `SecureStorageKey` sang chuỗi để sử dụng làm key
  String _keyToString(SecureStorageKey key) => key.name;

  /// Lưu dữ liệu
  Future<void> saveData(SecureStorageKey key, String value) async {
    await _secureStorage.write(key: _keyToString(key), value: value);
  }

  /// Lấy dữ liệu
  Future<String?> getData(SecureStorageKey key) async {
    return await _secureStorage.read(key: _keyToString(key));
  }

  /// Xóa dữ liệu theo key
  Future<void> deleteData(SecureStorageKey key) async {
    await _secureStorage.delete(key: _keyToString(key));
  }

  /// Xóa tất cả dữ liệu
  Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }



  Future<void> setSpeedLimits(Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits) async {
    final Map<String, dynamic> jsonMap = allSpeedLimits.map((key, value) {
      return MapEntry(key.toString(), value.toJson());
    });
    final jsonString = jsonEncode(jsonMap);
    await _secureStorage.write(
      key: SecureStorageKey.secureLimitSpeed.name,
      value: jsonString,
    );

   }

  Future<Map<VehicleWithSpeedLimit, ItemSpeed>> getSpeedLimits() async {
    final encryptedJson = await _secureStorage.read(key: SecureStorageKey.secureLimitSpeed.name);
    if (encryptedJson != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(encryptedJson);
      final Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits = jsonMap.map((key, value) {
        final speedLimit = VehicleWithSpeedLimit.values.firstWhere((e) => e.toString() == key);
        return MapEntry(speedLimit, ItemSpeed.fromJson(value));
      });
      return allSpeedLimits;
    } else {
      return VehicleWithSpeedLimit.loadSpeedLimits();
    }
  }
}
