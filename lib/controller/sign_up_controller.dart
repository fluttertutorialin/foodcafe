import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resource/api.dart';
import '../resource/routes.dart';
import '../shared/repository/local_auth_repository.dart';
import '../utils/extensions.dart';
import '../utils/state_status.dart';

class SingUpController extends GetxController {
  static SingUpController get to => Get.find();
  final _localAuthRepository = Get.find<LocalAuthRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.initial);

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
  final secureStorageEmailRx = Rx<String>('');

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
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callSignUp() async {
    stateStatus.value = StateStatus.loading;

    var param = {};
    param['userName'] = _userName;
    param['email'] = _email;
    param['password'] = _password;
    param['confirmPassword'] = _confirmPassword;
    param['mobile'] = _mobile;

    _localAuthRepository.writeSession(secureStorageUsername, _userName);
    _localAuthRepository.writeSession(secureStorageEmail, _email);
    _localAuthRepository.writeSession(secureStorageProfileUrl, '');
    _localAuthRepository.writeSession(secureStorageToken, '');
    _localAuthRepository.writeSession(secureStorageUserId, '');
    _localAuthRepository.writeSession(secureStorageMobile, _mobile);

    _localAuthRepository.writeSession(secureStorageWhereLogin, whereLogin);
    _localAuthRepository.writeSession(secureStorageOnBoarding, onBoarding);
    await Future.delayed(const Duration(seconds: 2));

    stateStatus.value = StateStatus.success;
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
