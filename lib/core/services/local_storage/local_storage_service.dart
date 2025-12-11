abstract interface class LocalStorageService {
  bool get hasInitialized;

  Future<void> initialize();

  Future<String?> get(String key);

  Future<bool> set(String key, String value);

  Future<bool> remove(String key);

  Future<void> clear();
}
