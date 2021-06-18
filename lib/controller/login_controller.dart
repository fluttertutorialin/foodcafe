import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../resource/value.dart';
import '../shared/repository/firestore_database_repository.dart';
import '../shared/repository/local_auth_repository.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';


class LoginController extends GetxController {
  static LoginController get to => Get.find();

  LoginController({this.localAuthRepository, this.fireStoreDatabaseRepository});

  /// inject repo abstraction dependency
  final LocalAuthRepository localAuthRepository;
  final FireStoreDatabaseRepository fireStoreDatabaseRepository;

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String _email = '', _password = '';

  var _autoValidate = Rx<bool>(false);
  var passwordVisible = Rx<bool>(true);

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  togglePasswordVisibility() {
    this.passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callLogin() async {
    NetworkController.to.initConnectivity().then((value) async {
      if (value > netWorkConnectionError) {
        stateStatus.value = StateStatus.LOADING;

        /*final _loginParam = LoginParam(_email, _password);
    fireStoreDatabaseRepository.login(
      body: _loginParam.toJson(),
        success: (value) {
          stateStatus.value = StateStatus.SUCCESS;
          print(value);
          /*var loginList =
              value.map((m) => LoginResponse.fromJson(m)).toList();
          print(loginList.length);*/
        },
        error: (value) {
          stateStatus.value = StateStatus.SUCCESS;
          passwordController.clear();
          _password = '';

          toast(
              title: 'Login error',
              message: value.message,
              textColor: toastMessageOrderColor,
              backgroundColor: toastBackgroundOrderColor,
              flushBarPosition: toastOrderPosition);
        });*/

        localAuthRepository.writeSession(
            SECURE_STORAGE_USERNAME, developerName);
        localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, developerEmail);
        localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, '');
        localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, '');
        localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, '');
        localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, '');
        localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '123456');
        localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, 'Address');
        localAuthRepository.writeSession(
            SECURE_STORAGE_WHERE_LOGIN, WHERE_LOGIN);
        localAuthRepository.writeSession(
            SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

        await Future.delayed(Duration(seconds: 2));
        stateStatus.value = StateStatus.SUCCESS;
        _clearTextField();

        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callGoogleLogin() async {
    fireStoreDatabaseRepository.googleLogin().then((user) {
      if (user != null) {
        stateStatus.value = StateStatus.SUCCESS;

        localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, user.displayName.split(' ')[0]);
        localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, user.email);
        localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, user.photoURL);
        localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, user.refreshToken);
        localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, user.uid);
        localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, user.phoneNumber);
        localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '362130');
        localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, 'To. Ravani Ta.Visavadar Dis.Junagadh');
        localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_GOOGLE_LOGIN);
        localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

        stateStatus.value = StateStatus.SUCCESS;
        _clearTextField();

        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callFacebookLogin() async {
    localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, ''.split(' ')[0]);
    localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, '');
    localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, '');
    localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, '');
    localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, '');
    localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, '');
    localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '');
    localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, '');
    localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_GOOGLE_LOGIN);

    localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);
    Get.offNamedUntil(homeRoute, (_) => false);
  }

  _clearTextField() {
    if (_email.isNotEmpty || _password.isNotEmpty) {
      emailController.clear();
      passwordController.clear();

      _email = '';
      _password = '';
    }
  }

  signUpLink() => Get.toNamed(signUpRoute);

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
