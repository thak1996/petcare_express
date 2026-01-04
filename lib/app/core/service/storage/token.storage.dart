import 'secure_storage.service.dart';

abstract class ITokenStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clear();
}

class TokenStorageImpl implements ITokenStorage {
  final ISecureStorage _storage;
  static const _key = 'auth_token_jwt';

  TokenStorageImpl(this._storage);

  @override
  Future<void> saveToken(String token) => _storage.save(_key, token);

  @override
  Future<String?> getToken() => _storage.read(_key);

  @override
  Future<void> clear() => _storage.delete(_key);
}
