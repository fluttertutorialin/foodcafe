import 'package:flutter/material.dart';
import 'package:foodcafe/resource/api.dart';
import 'package:foodcafe/resource/routes.dart';
import 'package:foodcafe/shared/repository/local_auth_repository.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:foodcafe/utils/state_status.dart';
import 'package:get/get.dart';

class SingUpController extends GetxController {
  static SingUpController get to => Get.find();
  var _localAuthRepository = Get.find<LocalAuthRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var mobileController = TextEditingController();

  String _userName = '',
      _email = '',
      _password = '',
      _confirmPassword = '',
      _mobile = '';

  final _autoValidate = Rx<bool>(false);
  final passwordVisible = Rx<bool>(true);

  final secureStorageUserName = Rx<String>('');
  final secureStorageProfileURL = Rx<String>('');
  final secureStorageEmail = Rx<String>('');

  changeUserName(String value) {
    _userName = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeConfirmPassword(String value) {
    _confirmPassword = value;
  }

  changeMobile(String value) {
    _mobile = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  togglePasswordVisibility() {
    this.passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callSignUp() async {
    stateStatus.value = StateStatus.LOADING;

    var param = new Map();
    param['userName'] = _userName;
    param['email'] = _email;
    param['password'] = _password;
    param['confirmPassword'] = _confirmPassword;
    param['mobile'] = _mobile;

    _localAuthRepository.writeSession(SECURE_STORAGE_USERNAME, _userName);
    _localAuthRepository.writeSession(SECURE_STORAGE_EMAIL, _email);
    _localAuthRepository.writeSession(SECURE_STORAGE_PROFILE_URL, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_TOKEN, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_USER_ID, '');
    _localAuthRepository.writeSession(SECURE_STORAGE_MOBILE, _mobile);

    _localAuthRepository.writeSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_LOGIN);
    _localAuthRepository.writeSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);
    await Future.delayed(Duration(seconds: 2));

    stateStatus.value = StateStatus.SUCCESS;
    _clearTextField();
    Get.offNamedUntil(homeRoute, (_) => false);
  }

  _clearTextField() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
  }

  String isUserNameValid(String value) => value.validUserName();

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  String isMobileValid(String value) => value.validateMobile();

  @override
  void dispose() {
    super.dispose();

    _userName = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _mobile = '';

    userNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    mobileController.text = '';
  }
}
