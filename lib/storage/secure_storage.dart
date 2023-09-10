import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() =>
      _instance ??= SecureStorage._(const FlutterSecureStorage());

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';
  static const _emailKey = 'EMAIL';

  SecureStorage._(this._storage);

  Future<void> saveEmailAndToken(String email, String token) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<bool> hasToken() async {
    var token = await _storage.read(key: _tokenKey);
    return token != null;
  }

  Future<bool> hasEmail() async {
    var email = await _storage.read(key: _emailKey);
    return email != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<void> deleteEmail() async {
    return _storage.delete(key: _emailKey);
  }

  Future<String?> getEmail() async {
    return _storage.read(key: _emailKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<void> clearStorage() async {
    return _storage.deleteAll();
  }
}
