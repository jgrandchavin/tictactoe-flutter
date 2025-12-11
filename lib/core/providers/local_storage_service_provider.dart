import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_flutter/core/services/local_storage/local_storage_service.dart';
import 'package:tictactoe_flutter/core/services/local_storage/shared_prefs_storage_service.dart';

part 'local_storage_service_provider.g.dart';

@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  return SharedPrefsStorageService();
}
