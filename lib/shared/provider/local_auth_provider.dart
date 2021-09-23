import 'package:get_storage/get_storage.dart';
import '../../resource/api.dart';

class LocalAuthProvider {
  final GetStorage _storage;

  LocalAuthProvider(this._storage);

  clearSession() {
    _storage.remove(secureStorageUsername);
    _storage.remove(secureStorageEmail);
    _storage.remove( secureStorageMobile);
    _storage.remove(secureStorageProfileUrl);
    _storage.remove(secureStorageUserId);
    _storage.remove(secureStorageToken);
    _storage.remove(secureStoragePinCode);
    _storage.remove(secureStorageAddress);
    _storage.remove(secureStorageWhereLogin);
  }

  writeSession(String key, String value)  {
    _storage.write(key, value);
  }

  bool hasDataSession(String key){
    return _storage.hasData(key);
  }

  String readSession(String key) {
    final sessionData = _storage.read(key);
    if (sessionData != null) {
      return sessionData;
    }
    return null;
  }
}
