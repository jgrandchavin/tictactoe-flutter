import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe_flutter/core/services/local_storage/local_storage_service.dart';

class SharedPrefsStorageService implements LocalStorageService {
  SharedPreferences? _sharedPreferences;

  @override
  bool get hasInitialized => _sharedPreferences != null;

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    await _sharedPreferences!.clear();
  }

  @override
  Future<String?> get(String key) async {
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _sharedPreferences!.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _sharedPreferences!.remove(key);
  }

  @override
  Future<bool> set(String key, String value) async {
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _sharedPreferences!.setString(key, value);
  }
}
