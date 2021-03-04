import 'package:foodcafe/resource/api.dart';
import 'package:get_storage/get_storage.dart';

class LocalAuthProvider {
  final GetStorage _storage;

  LocalAuthProvider(this._storage);

  clearSession() {
    _storage.remove(SECURE_STORAGE_USERNAME);
    _storage.remove(SECURE_STORAGE_EMAIL);
    _storage.remove( SECURE_STORAGE_MOBILE);
    _storage.remove(SECURE_STORAGE_PROFILE_URL);
    _storage.remove(SECURE_STORAGE_USER_ID);
    _storage.remove(SECURE_STORAGE_TOKEN);
    _storage.remove(SECURE_STORAGE_PINCODE);
    _storage.remove(SECURE_STORAGE_ADDRESS);
    _storage.remove(SECURE_STORAGE_WHERE_LOGIN);
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
