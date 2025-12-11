import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/services/local_storage/shared_prefs_storage_service.dart';

part 'local_storage_service.g.dart';

abstract interface class LocalStorageService {
  bool get hasInitialized;

  Future<void> initialize();

  Future<String?> get(String key);

  Future<bool> set(String key, String value);

  Future<bool> remove(String key);

  Future<void> clear();
}

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return SharedPrefsStorageService();
}
