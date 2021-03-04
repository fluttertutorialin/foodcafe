import 'package:flutter/material.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:foodcafe/shared/repository/firestore_database_repository.dart';
import 'package:foodcafe/shared/repository/local_auth_repository.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

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

    _localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, developerName);
    _localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, developerEmail);
    _localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '123456');
    _localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, 'Address');
    _localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_LOGIN);
    _localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

    await Future.delayed(Duration(seconds: 2));
    stateStatus.value = StateStatus.SUCCESS;
    _clearTextField();

    Get.offNamedUntil(homeRoute, (_) => false);
  }

  Future<void> callGoogleLogin() async {
    fireStoreDatabaseRepository.googleLogin().then((user) {
      if (user != null) {
        stateStatus.value = StateStatus.SUCCESS;

        _localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, user.displayName.split(' ')[0]);
        _localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, user.email);
        _localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, user.photoURL);
        _localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, user.refreshToken);
        _localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, user.uid);
        _localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, user.phoneNumber);
        _localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '362130');
        _localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, 'To. Ravani Ta.Visavadar Dis.Junagadh');
        _localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_GOOGLE_LOGIN);
        _localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

        stateStatus.value = StateStatus.SUCCESS;
        _clearTextField();

        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callFacebookLogin() async {
    _localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, ''.split(' ')[0]);
    _localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL,'');
    _localAuthRepository.writeSession(SECURE_STORAGE_TOKEN,'');
    _localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_PINCODE, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_ADDRESS, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_GOOGLE_LOGIN);

    _localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);
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
