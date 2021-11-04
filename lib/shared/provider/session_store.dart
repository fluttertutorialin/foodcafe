import '../../resource/api.dart';
import '../repository/local_auth_repository.dart';

abstract class SessionStore {
  void userId(String value);
  void token(String value);
  void userName(String value);
  void email(String value);
  void profileUrl(String value);
  void mobile(String value);
  void pinCode(String value);
  void address(String value);
  void whereLogin(String value);
  void onBoarding(String value);
}

class SessionStoreImp extends SessionStore {
  final LocalAuthRepository localAuthRepository;

  SessionStoreImp(this.localAuthRepository);

  @override
  void userId(String value) {
    localAuthRepository.writeSession(secureStorageUsername, value);
  }

  @override
  void address(String value) {
    localAuthRepository.writeSession(secureStorageAddress, 'Address');
  }

  @override
  void mobile(String value) {
    localAuthRepository.writeSession(secureStorageMobile, value);
  }

  @override
  void pinCode(String value) {
    localAuthRepository.writeSession(secureStoragePinCode, value);
  }

  @override
  void profileUrl(String value) {
    localAuthRepository.writeSession(secureStorageProfileUrl, value);
  }

  @override
  void token(String value) {
    localAuthRepository.writeSession(secureStorageToken, value);
  }

  @override
  void whereLogin(String value) {
    localAuthRepository.writeSession(secureStorageWhereLogin, value);
  }

  @override
  void onBoarding(String value) {
    localAuthRepository.writeSession(secureStorageOnBoarding, value);
  }

  @override
  void userName(String value) {
    localAuthRepository.writeSession(secureStorageUsername, value);
  }

  @override
  void email(String value) {
    localAuthRepository.writeSession(secureStorageEmail, value);
  }
}
